/* LVGL Example project
 *
 * Basic project to test LVGL on ESP32 based projects.
 *
 * This example code is in the Public Domain (or CC0 licensed, at your option.)
 *
 * Unless required by applicable law or agreed to in writing, this
 * software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied.
 */
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "driver/gpio.h"
#include "driver/uart.h"
#include "esp_freertos_hooks.h"
#include "esp_system.h"
#include "freertos/FreeRTOS.h"
#include "freertos/semphr.h"
#include "freertos/task.h"

/* Littlevgl specific */
#ifdef LV_LVGL_H_INCLUDE_SIMPLE

#include "lvgl.h"

#else
#include "lvgl/lvgl.h"
#endif

#include "lvgl_helpers.h"

#ifndef CONFIG_LV_TFT_DISPLAY_MONOCHROME
#if defined CONFIG_LV_USE_DEMO_WIDGETS

#include "lv_examples/src/lv_demo_widgets/lv_demo_widgets.h"

#elif defined CONFIG_LV_USE_DEMO_KEYPAD_AND_ENCODER
#include "lv_examples/src/lv_demo_keypad_encoder/lv_demo_keypad_encoder.h"
#elif defined CONFIG_LV_USE_DEMO_BENCHMARK
#include "lv_examples/src/lv_demo_benchmark/lv_demo_benchmark.h"
#elif defined CONFIG_LV_USE_DEMO_STRESS
#include "lv_examples/src/lv_demo_stress/lv_demo_stress.h"
#else
#error "No demo application selected."
#endif
#endif

/*********************
 *      DEFINES
 *********************/
#define TAG "methane_esp32"
#define LV_TICK_PERIOD_MS 1
#define UART_RXD (GPIO_NUM_9)
#define UART_TXD (GPIO_NUM_10)
#define UART_RTS (UART_PIN_NO_CHANGE)
#define UART_CTS (UART_PIN_NO_CHANGE)
#define UART_BAUDRATE 115200
#define UART_PORT_NUM UART_NUM_1

/**********************
 *  STATIC PROTOTYPES
 **********************/
static void lv_tick_task(void *arg);
static void guiTask(void *pvParameter);
static void create_demo_application(void);
static void show_welcome(void);
static void uart_recv_task(void *arg);

/**********************
 *   APPLICATION MAIN
 **********************/
void app_main() {

  /* If you want to use a task to create the graphic, you NEED to create a
   * Pinned task Otherwise there can be problem such as memory corruption and so
   * on. NOTE: When not using Wi-Fi nor Bluetooth you can pin the guiTask to
   * core 0 */
  xTaskCreatePinnedToCore(guiTask, "gui", 4096 * 2, NULL, 0, NULL, 1);
  xTaskCreatePinnedToCore(uart_recv_task, "uart_recv", 4096 * 2, NULL, 0, NULL,
                          1);
}

/* Creates a semaphore to handle concurrent call to lvgl stuff
 * If you wish to call *any* lvgl function from other threads/tasks
 * you should lock on the very same semaphore! */
SemaphoreHandle_t xGuiSemaphore;

static void guiTask(void *pvParameter) {

  (void)pvParameter;
  xGuiSemaphore = xSemaphoreCreateMutex();

  lv_init();

  /* Initialize SPI or I2C bus used by the drivers */
  lvgl_driver_init();

  lv_color_t *buf1 =
      heap_caps_malloc(DISP_BUF_SIZE * sizeof(lv_color_t), MALLOC_CAP_DMA);
  assert(buf1 != NULL);

  /* Use double buffered when not working with monochrome displays */
#ifndef CONFIG_LV_TFT_DISPLAY_MONOCHROME
  lv_color_t *buf2 =
      heap_caps_malloc(DISP_BUF_SIZE * sizeof(lv_color_t), MALLOC_CAP_DMA);
  assert(buf2 != NULL);
#else
  static lv_color_t *buf2 = NULL;
#endif

  static lv_disp_buf_t disp_buf;

  uint32_t size_in_px = DISP_BUF_SIZE;

#if defined CONFIG_LV_TFT_DISPLAY_CONTROLLER_IL3820 ||                         \
    defined CONFIG_LV_TFT_DISPLAY_CONTROLLER_JD79653A ||                       \
    defined CONFIG_LV_TFT_DISPLAY_CONTROLLER_UC8151D ||                        \
    defined CONFIG_LV_TFT_DISPLAY_CONTROLLER_SSD1306

  /* Actual size in pixels, not bytes. */
  size_in_px *= 8;
#endif

  /* Initialize the working buffer depending on the selected display.
   * NOTE: buf2 == NULL when using monochrome displays. */
  lv_disp_buf_init(&disp_buf, buf1, buf2, size_in_px);

  lv_disp_drv_t disp_drv;
  lv_disp_drv_init(&disp_drv);
  disp_drv.flush_cb = disp_driver_flush;

#if defined CONFIG_DISPLAY_ORIENTATION_PORTRAIT ||                             \
    defined CONFIG_DISPLAY_ORIENTATION_PORTRAIT_INVERTED
  disp_drv.rotated = 1;
#endif

  /* When using a monochrome display we need to register the callbacks:
   * - rounder_cb
   * - set_px_cb */
#ifdef CONFIG_LV_TFT_DISPLAY_MONOCHROME
  disp_drv.rounder_cb = disp_driver_rounder;
  disp_drv.set_px_cb = disp_driver_set_px;
#endif

  disp_drv.buffer = &disp_buf;
  lv_disp_drv_register(&disp_drv);

  /* Register an input device when enabled on the menuconfig */
#if CONFIG_LV_TOUCH_CONTROLLER != TOUCH_CONTROLLER_NONE
  lv_indev_drv_t indev_drv;
  lv_indev_drv_init(&indev_drv);
  indev_drv.read_cb = touch_driver_read;
  indev_drv.type = LV_INDEV_TYPE_POINTER;
  lv_indev_drv_register(&indev_drv);
#endif

  /* Create and start a periodic timer interrupt to call lv_tick_inc */
  const esp_timer_create_args_t periodic_timer_args = {
      .callback = &lv_tick_task, .name = "periodic_gui"};
  esp_timer_handle_t periodic_timer;
  ESP_ERROR_CHECK(esp_timer_create(&periodic_timer_args, &periodic_timer));
  ESP_ERROR_CHECK(
      esp_timer_start_periodic(periodic_timer, LV_TICK_PERIOD_MS * 1000));

  show_welcome();

  while (1) {
    /* Delay 1 tick (assumes FreeRTOS tick is 10ms */
    vTaskDelay(pdMS_TO_TICKS(10));

    /* Try to take the semaphore, call lvgl related function on success */
    if (pdTRUE == xSemaphoreTake(xGuiSemaphore, portMAX_DELAY)) {
      lv_task_handler();
      xSemaphoreGive(xGuiSemaphore);
    }
  }

  /* A task should NEVER return */
  free(buf1);
#ifndef CONFIG_LV_TFT_DISPLAY_MONOCHROME
  free(buf2);
#endif
  vTaskDelete(NULL);
}

static void create_demo_application(void) {
  /* When using a monochrome display we only show "Hello World" centered on the
   * screen */
#if defined CONFIG_LV_TFT_DISPLAY_MONOCHROME ||                                \
    defined CONFIG_LV_TFT_DISPLAY_CONTROLLER_ST7735S

  /* use a pretty small demo for monochrome displays */
  /* Get the current screen  */
  lv_obj_t *scr = lv_disp_get_scr_act(NULL);

  /*Create a Label on the currently active screen*/
  lv_obj_t *label1 = lv_label_create(scr, NULL);

  /*Modify the Label's text*/
  lv_label_set_text(label1, "Hello\nworld");

  /* Align the Label to the center
   * NULL means align on parent (which is the screen now)
   * 0, 0 at the end means an x, y offset after alignment*/
  lv_obj_align(label1, NULL, LV_ALIGN_CENTER, 0, 0);
#else
  /* Otherwise we show the selected demo */

#if defined CONFIG_LV_USE_DEMO_WIDGETS
  lv_demo_widgets();
#elif defined CONFIG_LV_USE_DEMO_KEYPAD_AND_ENCODER
  lv_demo_keypad_encoder();
#elif defined CONFIG_LV_USE_DEMO_BENCHMARK
  lv_demo_benchmark();
#elif defined CONFIG_LV_USE_DEMO_STRESS
  lv_demo_stress();
#else
#error "No demo application selected."
#endif
#endif
}

static void show_welcome(void) {

  lv_obj_t *screen = lv_disp_get_scr_act(NULL);

  static lv_style_t style_screen;
  lv_style_init(&style_screen);
  lv_style_set_bg_color(&style_screen, LV_STATE_DEFAULT, LV_COLOR_BLACK);
  lv_obj_add_style(lv_scr_act(), LV_OBJ_PART_MAIN, &style_screen);

  static lv_style_t style_text;
  lv_style_init(&style_text);
  lv_style_set_text_color(&style_text, LV_STATE_DEFAULT, LV_COLOR_WHITE);

  static lv_style_t style_circle;
  lv_style_init(&style_circle);
  lv_style_set_border_color(&style_circle, LV_STATE_DEFAULT, LV_COLOR_WHITE);
  lv_style_set_bg_opa(&style_circle, LV_STATE_DEFAULT, LV_OPA_TRANSP);

  lv_obj_t *label1 = lv_label_create(screen, NULL);
  lv_label_set_text(label1, "METHANE SYNTH");
  lv_obj_set_pos(label1, 50, 30);
  lv_obj_add_style(label1, LV_OBJ_PART_MAIN, &style_text);

  lv_obj_t *label_version = lv_label_create(screen, NULL);
  lv_label_set_text(label_version, "MODEL V1");
  lv_obj_set_pos(label_version, 50, 50);
  lv_obj_add_style(label_version, LV_OBJ_PART_MAIN, &style_text);

  lv_obj_t *label2 = lv_label_create(screen, NULL);
  lv_label_set_text(label2, "wheatfox");
  lv_obj_set_pos(label2, 50, 90);
  lv_obj_add_style(label2, LV_OBJ_PART_MAIN, &style_text);

  lv_obj_t *circle1 = lv_obj_create(screen, NULL);
  lv_obj_set_size(circle1, 50, 50);
  lv_obj_set_pos(circle1, 200, 120);
  lv_obj_set_style_local_bg_color(circle1, LV_OBJ_PART_MAIN, LV_STATE_DEFAULT,
                                  LV_COLOR_TRANSP);
  lv_obj_set_style_local_radius(circle1, LV_OBJ_PART_MAIN, LV_STATE_DEFAULT,
                                LV_RADIUS_CIRCLE);
  lv_obj_add_style(circle1, LV_OBJ_PART_MAIN, &style_circle);

  lv_obj_t *circle2 = lv_obj_create(screen, circle1);
  lv_obj_set_size(circle2, 50, 50);
  lv_obj_set_pos(circle2, 220, 120);
  lv_obj_set_style_local_bg_color(circle2, LV_OBJ_PART_MAIN, LV_STATE_DEFAULT,
                                  LV_COLOR_TRANSP);
  lv_obj_set_style_local_radius(circle2, LV_OBJ_PART_MAIN, LV_STATE_DEFAULT,
                                LV_RADIUS_CIRCLE);
  lv_obj_add_style(circle2, LV_OBJ_PART_MAIN, &style_circle);

  lv_obj_t *canvas = lv_canvas_create(screen, NULL);
  lv_obj_set_size(canvas, 135, 20);
  lv_obj_set_pos(canvas, 50, 140);
  lv_canvas_set_buffer(canvas, lv_mem_alloc(135 * 20 * 2), 135, 20,
                       LV_IMG_CF_TRUE_COLOR);
  lv_canvas_fill_bg(canvas, LV_COLOR_BLACK, LV_OPA_COVER);

  lv_coord_t x, y;

  for (x = 0; x < 30; x++) {
    y = 10 + (int)(10 * sin(x * 2 * M_PI / 30));
    lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
  }

  for (x = 35; x < 65; x++) {
    lv_coord_t x1 = x - 35;
    if (x1 == 0) {
      for (y = 10; y < 20; y++) {
        lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
      }
    } else if (x1 < 15 && x1 > 0) {
      y = 19;
      lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
    } else if (x1 == 15) {
      for (y = 19; y >= 0; y--) {
        lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
      }
    } else if (x1 > 15 && x1 < 29) {
      y = 0;
      lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
    } else if (x1 == 29) {
      for (y = 0; y < 10; y++) {
        lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
      }
    }
  }

  for (x = 70; x < 100; x++) {
    lv_coord_t x1 = x - 70;
    if (x1 < 7) {
      y = x1 + 10;
    } else if (x1 < 21) {
      y = 14 - x1 + 10;
    } else {
      y = -28 + x1 + 10;
    }
    lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
  }

  for (x = 105; x < 135; x++) {
    lv_coord_t x1 = x - 105;
    if (x1 == 0) {
      for (y = 0; y < 20; y++) {
        lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
      }
    } else if (x1 <= 29) {
      y = 10 + (10 - (20. / 30) * x1);
      lv_canvas_set_px(canvas, x, 19 - y, LV_COLOR_WHITE);
    }
  }
}

static void lv_tick_task(void *arg) {
  (void)arg;
  lv_tick_inc(LV_TICK_PERIOD_MS);
}

static void uart_recv_task(void *arg) {
  /* Configure parameters of an UART driver,
   * communication pins and install the driver */
  uart_config_t uart_config = {
      .baud_rate = UART_BAUDRATE,
      .data_bits = UART_DATA_8_BITS,
      .parity = UART_PARITY_DISABLE,
      .stop_bits = UART_STOP_BITS_1,
      .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
      .source_clk = UART_SCLK_APB,
  };
  int intr_alloc_flags = 0;

#if CONFIG_UART_ISR_IN_IRAM
  intr_alloc_flags = ESP_INTR_FLAG_IRAM;
#endif

#define BUF_SIZE (1024)

  ESP_ERROR_CHECK(uart_driver_install(UART_PORT_NUM, BUF_SIZE * 2, 0, 0, NULL,
                                      intr_alloc_flags));
  ESP_ERROR_CHECK(uart_param_config(UART_PORT_NUM, &uart_config));
  ESP_ERROR_CHECK(
      uart_set_pin(UART_PORT_NUM, UART_TXD, UART_RXD, UART_RTS, UART_CTS));

  // Configure a temporary buffer for the incoming data
  uint8_t *data = (uint8_t *)malloc(BUF_SIZE);

  char *display_buffer = (char *)malloc(
      2048); // display received char in buffer and draw on screen
  int display_buffer_index = 0;

  // set init data of display buffer to "WAITING FOR UART DATA"

  while (1) {
    // Read data from the UART
    int len = uart_read_bytes(UART_PORT_NUM, data, (BUF_SIZE - 1),
                              20 / portTICK_PERIOD_MS);
    display_buffer_index += len;
    if (len > 0) {
      data[len] = 0;
      for (int i = 0; i < len; i++) {
        display_buffer[display_buffer_index - len + i] = data[i];
      }
      display_buffer[display_buffer_index] = 0;
      lv_obj_t *screen = lv_disp_get_scr_act(NULL);
      lv_obj_t *label = lv_label_create(screen, NULL);
      lv_label_set_text(label, display_buffer);
      lv_obj_set_pos(label, 50, 200);
    }
  }
}
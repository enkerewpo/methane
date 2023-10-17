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
#include "esp_log.h"
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
#define TAG "methane-esp32"
#define LV_TICK_PERIOD_MS 1

/**********************
 *  STATIC PROTOTYPES
 **********************/
static void lv_tick_task(void *arg);
static void gui_task(void *pvParameter);
static void uart_handle(void *pvParameter);
static void show_welcome(void);

/**********************
 *   APPLICATION MAIN
 **********************/
void app_main() {

  /* If you want to use a task to create the graphic, you NEED to create a
   * Pinned task Otherwise there can be problem such as memory corruption and so
   * on. NOTE: When not using Wi-Fi nor Bluetooth you can pin the gui_task to
   * core 0 */
  xTaskCreatePinnedToCore(gui_task, "gui", 4096 * 2, NULL, 0, NULL, 1);
  xTaskCreate(uart_handle, "uart_handle", 4096 * 2, NULL, 0, NULL);
}

/* Creates a semaphore to handle concurrent call to lvgl stuff
 * If you wish to call *any* lvgl function from other threads/tasks
 * you should lock on the very same semaphore! */
SemaphoreHandle_t xGuiSemaphore;

static void gui_task(void *pvParameter) {

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

lv_obj_t *screen;
lv_style_t style_screen;
lv_style_t style_text;

static void show_welcome(void) {

  screen = lv_disp_get_scr_act(NULL);

  lv_style_init(&style_screen);
  lv_style_set_bg_color(&style_screen, LV_STATE_DEFAULT, LV_COLOR_BLACK);
  lv_obj_add_style(lv_scr_act(), LV_OBJ_PART_MAIN, &style_screen);

  lv_style_init(&style_text);
  lv_style_set_text_color(&style_text, LV_STATE_DEFAULT, LV_COLOR_WHITE);

  //  static lv_style_t style_circle;
  //  lv_style_init(&style_circle);
  //  lv_style_set_border_color(&style_circle, LV_STATE_DEFAULT,
  //  LV_COLOR_WHITE); lv_style_set_bg_opa(&style_circle, LV_STATE_DEFAULT,
  //  LV_OPA_TRANSP);

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
}

char uart_msgbuf[1024];
int uart_msgbuf_len = 0;
#define UART_TXD (GPIO_NUM_10)
#define UART_RXD (GPIO_NUM_9)
#define UART_RTS (UART_PIN_NO_CHANGE)
#define UART_CTS (UART_PIN_NO_CHANGE)
#define BUF_SIZE (1024)
#define RD_BUF_SIZE (BUF_SIZE)
#define UART_NUM UART_NUM_1
#define UART_BAUD_RATE 115200

static void uart_handle(void *pvParameter) {
  // create uart driver
  uart_config_t uart_config = {
      .baud_rate = UART_BAUD_RATE,
      .data_bits = UART_DATA_8_BITS,
      .parity = UART_PARITY_DISABLE,
      .stop_bits = UART_STOP_BITS_1,
      .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
      .source_clk = UART_SCLK_APB,
  };
  ESP_ERROR_CHECK(uart_driver_install(UART_NUM, BUF_SIZE * 2, 0, 0, NULL, 0));
  ESP_ERROR_CHECK(uart_param_config(UART_NUM, &uart_config));
  ESP_ERROR_CHECK(
      uart_set_pin(UART_NUM, UART_TXD, UART_RXD, UART_RTS, UART_CTS));
  uint8_t *data = (uint8_t *)malloc(BUF_SIZE);

  memcpy(uart_msgbuf, "UART_IDLE", 10);
  uart_msgbuf_len = 10;

  while (1) {
    vTaskDelay(1000 / portTICK_RATE_MS);
    // read data from uart
    int len = uart_read_bytes(UART_NUM, data, BUF_SIZE, 20 / portTICK_RATE_MS);
    if (len > 0) {
      ESP_LOGI(TAG, "uart read : %d", len);
      for (int i = 0; i < len; i++) {
        uart_msgbuf[uart_msgbuf_len++] = data[i];
      }
    }
    // try to take the semaphore, call lvgl related function on success
    if (pdTRUE == xSemaphoreTake(xGuiSemaphore, portMAX_DELAY)) {
      ESP_LOGI(TAG, "uart_handle_gui_draw");
      // flush the screen
      lv_obj_clean(screen);
      // draw the text
      lv_obj_t *label = lv_label_create(screen, NULL);
      lv_label_set_text(label, uart_msgbuf);
      lv_obj_set_pos(label, 50, 110);
      lv_obj_add_style(label, LV_OBJ_PART_MAIN, &style_text);
      xSemaphoreGive(xGuiSemaphore);
    }
  }
}

static void lv_tick_task(void *arg) {
  (void)arg;
  lv_tick_inc(LV_TICK_PERIOD_MS);
}

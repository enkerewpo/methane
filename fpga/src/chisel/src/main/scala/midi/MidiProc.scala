package midi

import chisel3._
import chisel3.util._
import uart.UART_rx

/**
 * MIDI processing module
 *
 * @author wheatfox
 * @version 20230305
 */
class MidiProc extends Module {

  val io = IO(new Bundle {
    val en = Input(Bool()) // enable
    val midi_in = Input(Bool())
    val freq = Output(UInt(32.W))
    val note_on = Output(Bool())
    val note_off = Output(Bool())
  })

  val uart_r = Module(new UART_rx(
    bitRate = 31250,
    clkFreq = 10000000 // 10M
  ))

  val byte_ok = Wire(Bool())
  val byte_r = RegInit(0.U(8.W))

  uart_r.io.i_serial_data := io.midi_in
  byte_ok := uart_r.io.o_rx_done

  val s_idle :: s_status :: s_data1 :: Nil = Enum(3)
  val state = RegInit(s_idle)

  val sbyte_type = Wire(UInt(4.W))
  val sbyte_channel = Wire(UInt(4.W))
  sbyte_type := byte_r(7, 4)
  sbyte_channel := byte_r(3, 0)

  val sbyte = RegInit(0.U(4.W)) // status byte
  val note = RegInit(0.U(7.W))
  val velocity = RegInit(0.U(7.W))

  val freq_table = VecInit(
    Seq.tabulate(128)(i => scala.math.round(scala.math.pow(2.0, (i - 69) / 12.0) * 440.0 * 100).toInt.asUInt(32.W))
  )

  io.freq := freq_table(note)

  val s_note_off = 0x8.U
  val s_note_on = 0x9.U

  val note_on = RegInit(false.B)
  val note_off = RegInit(false.B)

  switch(state) {
    is(s_idle) {
      when(byte_ok) {
        byte_r := uart_r.io.o_data
        state := s_status
        sbyte := byte_r // save the status byte
      }
    }
    is(s_status) {
      when(byte_ok) {
        byte_r := uart_r.io.o_data
        switch(sbyte) {
          is(s_note_on) {
            note := byte_r
            state := s_data1 // goto data1
          }
          is(s_note_off) {
            note := byte_r
            state := s_data1 // goto data1
          }
        }
      }
    }
    is(s_data1) {
      when(byte_ok) {
        byte_r := uart_r.io.o_data
        switch(sbyte) {
          is(s_note_on) {
            velocity := byte_r
            // now we finished the note on event
            // [ NOTE_ON | NOTE | VELOCITY]
            // if the velocity is 0, it is a note off event
            when(velocity === 0.U) {
              note_off := true.B
            }.otherwise {
              note_on := true.B
            }
            state := s_idle // goto idle
          }
          is(s_note_off) {
            velocity := byte_r
            // now we finished the note off event
            // [ NOTE_OFF | NOTE | VELOCITY]
            note_off := true.B
            state := s_idle // goto idle
          }
        }
      }
    }
  }

  when(note_on) {
    printf("NOTE_ON: %d\n", note)
    note_on := false.B
  }
  when(note_off) {
    printf("NOTE_OFF: %d\n", note)
    note_off := false.B
  }

  io.note_on := note_on
  io.note_off := note_off

}

package methane

import chisel3._
import chisel3.util._
import midi.MidiProc

/**
 * ADSR module triggered by MIDI note on/off, and send signals to VCA
 *
 * @author wheatfox
 * @version 20230807
 */
class ADSR extends Module {
  val io = IO(
    new Bundle {
      val en = Input(Bool()) // enable
      /** * MIDI note events ** */
      val note_on = Input(Bool())
      val note_off = Input(Bool())
      /** * ADSR parameters ** */
      val attack = Input(UInt(16.W))
      val decay = Input(UInt(16.W))
      val sustain = Input(UInt(16.W)) // VOLTAGE
      val release = Input(UInt(16.W))
      /** * ADSR output ** */
      val out = Output(UInt(16.W)) // output 16bit value, which can be seen as the VOLTAGE
    }
  )
  // ADSR state machine
  val s_idle :: s_attack :: s_decay :: s_sustain :: s_release :: Nil = Enum(5)

  // io.attack, io.decay, io.release: 0 ~ 65535 will be the attack time in clock cycles
  // STAGES:
  //    0. IDLE: out stays at 0 until note_on, goto ATTACK
  //    1. ATTACK: out goes from 0 to 65535 in io.attack clock cycles linearly(if reaches 65535, go to next stage, else goto RELEASE)
  //    2. DECAY: out goes from 65535 to io.sustain in io.decay clock cycles linearly(if reaches io.sustain, go to next stage, else goto RELEASE)
  //    3. SUSTAIN: out stays at io.sustain until note_off
  //    4. RELEASE: out goes from io.sustain to 0 in io.release clock cycles linearly(if reaches 0, exit and return to IDLE)

  val state = RegInit(s_idle)
  val counter = RegInit(0.U(16.W))
  val out = RegInit(0.U(16.W))

  // we need to dynamically update the slope of each transition according to the parameters
  val attack_slope = RegInit(0.U(16.W))
  val decay_slope = RegInit(0.U(16.W))
  val release_slope = RegInit(0.U(16.W))
  attack_slope := 65000.U(16.W) / io.attack
  decay_slope := (65000.U(16.W) - io.sustain) / io.decay // store decay slope as positive value
  release_slope := io.sustain / io.release // store release slope as positive value

  switch(state) {
    // IDLE
    is(s_idle) {
      when(io.note_on) {
        state := s_attack
        counter := 0.U(16.W)
        out := 0.U(16.W)
      }
    }
    // ATTACK
    is(s_attack) {
      when(io.note_off) {
        state := s_release
        counter := 0.U(16.W)
      }.elsewhen(counter === io.attack) {
        state := s_decay
        counter := 0.U(16.W)
      }.otherwise {
        counter := counter + 1.U(16.W)
        out := out + attack_slope
      }
    }
    // DECAY
    is(s_decay) {
      when(io.note_off) {
        state := s_release
        counter := 0.U(16.W)
      }.elsewhen(counter === io.decay) {
        state := s_sustain
        counter := 0.U(16.W)
      }.otherwise {
        counter := counter + 1.U(16.W)
        out := out - decay_slope
      }
    }
    // SUSTAIN
    is(s_sustain) {
      when(io.note_off) {
        state := s_release
        counter := 0.U(16.W)
      }
    }
    // RELEASE
    is(s_release) {
      when(counter === io.release) {
        state := s_idle
        counter := 0.U(16.W)
        out := 0.U(16.W)
      }.otherwise {
        counter := counter + 1.U(16.W)
        out := out - release_slope
      }
    }
  }

  io.out := out

}
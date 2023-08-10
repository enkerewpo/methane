package methane

import chisel3._
import chisel3.util._


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
      val attack = Input(UInt(32.W))
      val decay = Input(UInt(32.W))
      val sustain = Input(UInt(32.W)) // VOLTAGE
      val release = Input(UInt(32.W))
      /** curve type selecttion */
      // 0: linear
      // 1: exponential
      // 2: logarithmic
      val attack_curve_type = Input(UInt(3.W))
      val decay_curve_type = Input(UInt(3.W))
      val release_curve_type = Input(UInt(3.W))
      /** * ADSR output ** */
      val out = Output(UInt(32.W)) // output 32bit value, which can be seen as the VOLTAGE
    }
  )
  // ADSR state machine
  val s_idle :: s_attack :: s_decay :: s_sustain :: s_release :: Nil = Enum(5)

  // io.attack, io.decay, io.release: 0 ~ 2^32 - 1 will be the attack time in clock cycles
  // STAGES:
  //    0. IDLE: out stays at 0 until note_on, goto ATTACK
  //    1. ATTACK: out goes from 0 to 65535 in io.attack clock cycles linearly(if reaches 65535, go to next stage, else goto RELEASE)
  //    2. DECAY: out goes from 65535 to io.sustain in io.decay clock cycles linearly(if reaches io.sustain, go to next stage, else goto RELEASE)
  //    3. SUSTAIN: out stays at io.sustain until note_off
  //    4. RELEASE: out goes from io.sustain to 0 in io.release clock cycles linearly(if reaches 0, exit and return to IDLE)

  val state = RegInit(s_idle)
  val counter = RegInit(0.U(32.W))
  val out = RegInit(0.U(32.W))

  // curve type
  val LINEAR = 0.U(3.W)
  val PARABOLIC_CONVEX = 1.U(3.W)
  val PARABOLIC_CONCAVE = 2.U(3.W)

  val MAX_32BIT = 4294967295L.U(32.W)

  // linear curve: y = kx
  val attack_k = RegInit(0.U(32.W))
  val decay_k = RegInit(0.U(32.W))
  val release_k = RegInit(0.U(32.W))
  attack_k := MAX_32BIT / io.attack
  decay_k := (MAX_32BIT - io.sustain) / io.decay // store decay slope as positive value
  release_k := io.sustain / io.release // store release slope as positive value

  // parabolic curve: y = ax^2
  // dy = 2axdx
  val attack_a = RegInit(0.U(32.W))
  val decay_a = RegInit(0.U(32.W))
  val release_a = RegInit(0.U(32.W))
  attack_a := MAX_32BIT / (io.attack * io.attack)
  decay_a := (MAX_32BIT - io.sustain) / (io.decay * io.decay)
  release_a := io.sustain / (io.release * io.release)

  switch(state) {
    // IDLE
    is(s_idle) {
      io.out := 0.U
      when(io.note_on) {
        state := s_attack
        counter := 0.U
        out := 0.U
      }
    }
    // ATTACK
    is(s_attack) {
      when(io.note_off) {
        state := s_release
        counter := 0.U
      }.elsewhen(counter === io.attack) {
        state := s_decay
        counter := 0.U
      }.otherwise {
        counter := counter + 1.U
        switch(io.attack_curve_type) {
          is(LINEAR) {
            out := attack_k * counter
          }
          is(PARABOLIC_CONVEX) {
            out := attack_a * counter * counter
          }
        }
      }
    }
    // DECAY
    is(s_decay) {
      when(io.note_off) {
        state := s_release
        counter := 0.U
        // TODO: when note_off is too early, smooth the transition into release stage?
      }.elsewhen(counter === io.decay) {
        state := s_sustain
        counter := 0.U
      }.otherwise {
        counter := counter + 1.U
        switch(io.decay_curve_type) {
          is(LINEAR) {
            out := MAX_32BIT - decay_k * counter
          }
          is(PARABOLIC_CONVEX) {
            out := io.sustain + decay_a * (io.decay - counter) * (io.decay - counter)
          }
          is(PARABOLIC_CONCAVE) {
            out := MAX_32BIT - decay_a * counter * counter
          }
        }
      }
    }
    // SUSTAIN
    is(s_sustain) {
      out := io.sustain
      when(io.note_off) {
        state := s_release
        counter := 0.U
      }
    }
    // RELEASE
    is(s_release) {
      when(counter === io.release) {
        state := s_idle
        counter := 0.U
        out := 0.U
      }.otherwise {
        counter := counter + 1.U(32.W)
        switch(io.release_curve_type) {
          is(LINEAR) {
            out := io.sustain - release_k * counter
          }
          is(PARABOLIC_CONVEX) {
            out := release_a * (io.release - counter) * (io.release - counter)
          }
          is(PARABOLIC_CONCAVE) {
            out := io.sustain - release_a * counter * counter
          }
        }
      }
    }
  }

  io.out := out

}
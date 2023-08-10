package methane

import chisel3._

/**
 * VCA(Voltage Controlled Amplifier) module
 *
 * @author wheatfox
 * @version 20230807
 */
class VCA extends Module {

  val io = IO(
    new Bundle {
      val en = Input(Bool()) // enable
      val in = Input(SInt(16.W))
      val control = Input(SInt(32.W)) // control voltage
      val out = Output(SInt(16.W)) // output 16bit sample point (signed)
    }
  )

  when(io.en) {
    io.out := io.in * io.control
  }.otherwise {
    io.out := 0.S(16.W)
  }

}

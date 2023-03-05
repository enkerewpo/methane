package Oscillator

import chisel3._
import chisel3.util._

/**
 * Oscillator module
 *
 * @author wheatfox
 * @version 20230305
 */
class Oscillator()
    extends Module {

    val io = IO(new Bundle {
        val en = Input(Bool()) // enable
        val freq = Input(UInt(16.W)) // note input frequency
        val out = Output(SInt(16.W)) // output 16bit sample point (signed)
    })

    val waveframe = VecInit(
        Seq.tabulate(256)(
            i => (scala.math.sin(2 * scala.math.Pi * i / 256) * 20000).toInt.S(16.W)
        )
    )
    // now test with a simple sine wave frame

    val samplePoint = Wire(SInt(16.W))
    val testReg = RegInit(0.U(16.W))
    when(io.en) {
        testReg := testReg + 1.U(16.W)
    }
    samplePoint := waveframe(testReg)
    io.out := samplePoint
}

object OscillatorGen extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Oscillator,
        Array("--target-dir", "output/")
    )
}

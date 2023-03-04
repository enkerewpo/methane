package Top

import Oscillator.Oscillator
import chisel3._

class Top extends Module {

    val io = IO(new Bundle {
        val out = Output(UInt(16.W))
    })

    val osc1 = Module(new Oscillator(freq = 440.0, sampleRate = 44100.0))
    io.out := osc1.io.out
}

object TopGen extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Top,
        Array("--target-dir", "output/")
    )
}

package Oscillator

import chisel3._

class Oscillator(
                    freq: Double,
                    sampleRate: Double
                )
    extends Module {

    val io = IO(new Bundle {
        val out = Output(UInt(16.W))
    })

    val sineTable = VecInit(
        Seq.tabulate(65536)(
            i => (scala.math.sin(2 * scala.math.Pi * i / 65536) * 32767.5 + 32767.5)
                .toInt.U(16.W)
        )
    )
    
    io.out := sineTable(60000)
}

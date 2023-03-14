package methane

import chisel3._

/**
 * Oscillator module
 *
 * @author wheatfox
 * @version 20230305
 */
class Oscillator() extends Module {

    val io = IO(new Bundle {
        val en = Input(Bool()) // enable
        val freq = Input(UInt(32.W)) // note input frequency
        val out = Output(SInt(16.W)) // output 16bit sample point (signed)
    })

    val waveform = VecInit(
        Seq.tabulate(256)(
            i => (
                scala.math.sin(2 * scala.math.Pi * i / 256)
                    * 20000).toInt.S(16.W)
        )
    )

    // now test with a simple sine waveform
    val samplePoint = Wire(SInt(16.W))
    val holdTick = RegInit(3906250.U(32.W) / io.freq)
    val runTick = RegInit(0.U(32.W))
    val idx = RegInit(0.U(16.W))

    when(io.en) {
        holdTick := 3906250.U(32.W) / io.freq
        runTick := runTick + 1.U(32.W)
        when(runTick === holdTick) {
            runTick := 0.U(32.W)
            idx := idx + 1.U(16.W)
            when(idx === 256.U(16.W)) {
                idx := 0.U(16.W)
            }
        }
    }
    samplePoint := waveform(idx)
    io.out := samplePoint
}
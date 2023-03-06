package I2S

import Chisel.Cat
import chisel3._

class I2S extends Module {
    val io = IO(new Bundle {
        val leftChannel = Input(UInt(16.W))
        val rightChannel = Input(UInt(16.W))
        val bitClock = Output(Bool())
        val wordSelect = Output(Bool())
        val serialData = Output(Bool())
    })

    val nclk = RegInit(false.B) // 44.1k * 16 * 2 = 1.4112M clock
    val nclk_cnt = RegInit(10.U)
    when(nclk_cnt === 0.U) {
        nclk := ~nclk
        nclk_cnt := 10.U
    }.otherwise {
        nclk_cnt := nclk_cnt - 1.U
    }

    val clk = nclk.asClock

    io.bitClock := clk

    val leftReg = RegInit(0.U(16.W))
    val rightReg = RegInit(0.U(16.W))
    val wordSelectReg = RegInit(true.B)

    withClock(clk) {

        val bitCounter = RegInit(0.U)

        when(bitCounter === 0.U) {
            bitCounter := 7.U
            wordSelectReg := !wordSelectReg
            leftReg := io.leftChannel
            rightReg := io.rightChannel
        }.otherwise {
            bitCounter := bitCounter - 1.U
        }

    }

}

object I2SGen extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new I2S,
        Array("--target-dir", "output/")
    )
}

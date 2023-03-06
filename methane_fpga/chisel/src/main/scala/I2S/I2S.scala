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

    val bitCounter = RegInit(0.U(4.W))

    // Interleave the data from the left and right channels
    val interleavedData = Cat(io.rightChannel, io.leftChannel)

    // The bit clock signal of the I2S protocol is a periodic signal that alternates between high and low
    val bitClock = RegInit(false.B)
    when(bitCounter === 7.U) {
        bitClock := ~bitClock
        bitCounter := 0.U
    }.otherwise {
        bitCounter := bitCounter + 1.U
    }

    // The word select signal of the I2S protocol is a periodic signal that goes high to indicate the start of a new word
    val wordSelect = RegInit(false.B)
    when(bitCounter === 0.U) {
        wordSelect := ~wordSelect
    }

    // The serial data signal of the I2S protocol is a rising edge triggered signal that carries the data
    val serialData = RegInit(false.B)
    when(bitCounter === 0.U) {
        serialData := false.B
    }.elsewhen(bitCounter === 15.U) {
        serialData := true.B
    }

    // Send the data and signals to the output ports
    io.bitClock := bitClock
    io.wordSelect := wordSelect
    io.serialData := Mux(serialData, interleavedData(0), !interleavedData(15.U-bitCounter))
}

object I2SGen extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new I2S,
        Array("--target-dir", "output/")
    )
}

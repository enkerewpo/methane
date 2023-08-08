package uart

import chisel3._
import chisel3.util._


class UART_rx (
              bitRate: Int = 115200,
              clkFreq: Int = 10000000, // 10M
              payloadBits: Int = 8
              ) extends Module {
  val io = IO(new Bundle() {
    val i_serial_data = Input(Bool())
    val o_rx_done = Output(Bool())
    val o_data = Output(UInt(payloadBits.W))
  })

  val clksPerBit = clkFreq / bitRate          // clocks per bit (CPB)
  val clkCnterBW = log2Ceil(clksPerBit) + 1   // bit width for clkCnterReg
  val bitCnterBW = log2Ceil(payloadBits) + 1  // bit width for bitCnterReg

  // fsm states
  val idle :: startBit :: dataBits :: stopBit :: Nil = Enum(4)

  val clkCnterReg = RegInit(0.U(clkCnterBW.W))  // counting clk edges
  val bitCnterReg = RegInit(0.U(bitCnterBW.W))  // counting bits transmitted

  val outDataReg = RegInit(VecInit(Seq.fill(payloadBits)(false.B))) // output data reg
  val outRxDoneReg = RegInit(false.B)              // output rx done reg
  val stateReg = RegInit(idle)                  // fsm state reg

  // input serial data synchronized to clk domain
  val serialDataReg = RegNext(RegNext(io.i_serial_data))

  io.o_data := Cat(outDataReg.reverse)
  io.o_rx_done := outRxDoneReg

  switch (stateReg) {
    is (idle) {
      outRxDoneReg := false.B
      // counters disabled
      clkCnterReg := 0.U(clkCnterBW.W)
      bitCnterReg := 0.U(bitCnterBW.W)
      // if serial input data low, go to startBit
      when (serialDataReg === false.B) {
        stateReg := startBit
      } .otherwise {
        stateReg := idle
      }
    }
    is (startBit) {
      when (clkCnterReg < (clksPerBit / 2).U) {
        clkCnterReg := clkCnterReg + 1.U
        stateReg := startBit
      } .otherwise {
        // we are at the middle of start bit
        clkCnterReg := 0.U(clkCnterBW.W)
        when (serialDataReg === false.B) {
          stateReg := dataBits
        } .otherwise {
          // treat as noise and go back to idle
          stateReg := idle
        }
      }
    }
    is (dataBits) {
      when (clkCnterReg < clksPerBit.U) {
        clkCnterReg := clkCnterReg + 1.U
      } .otherwise {
        clkCnterReg := 0.U(clkCnterBW.W)
        // we are at the middle of a data bit
        // grab data bit and update bitCnterReg
        outDataReg(bitCnterReg) := serialDataReg
        when (bitCnterReg < payloadBits.U) {
          bitCnterReg := bitCnterReg + 1.U
        } .otherwise {
          bitCnterReg := 0.U(bitCnterBW.W)
        }
      }
      when (bitCnterReg === payloadBits.U) {
        stateReg := stopBit
      } .otherwise {
        stateReg := dataBits
      }
    }
    is (stopBit) {
      when (clkCnterReg < clksPerBit.U) {
        clkCnterReg := clkCnterReg + 1.U
        stateReg := stopBit
      } .otherwise {
        clkCnterReg := 0.U(clkCnterBW.W)
        // we are at the middle of stop bit
        outRxDoneReg := true.B
        stateReg := idle
      }
    }
  }
}

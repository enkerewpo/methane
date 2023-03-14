import methane.Oscillator
import midi.MidiProc
import uart.UART_tx

object VerilogGen extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Oscillator,
        Array("--target-dir", "output/", "--full-stacktrace"),
    )
    (new chisel3.stage.ChiselStage).emitVerilog(new MidiProc,
        Array("--target-dir", "output/", "--full-stacktrace"),
    )
    (new chisel3.stage.ChiselStage).emitVerilog(new UART_tx,
        Array("--target-dir", "output/", "--full-stacktrace"),
    )
}
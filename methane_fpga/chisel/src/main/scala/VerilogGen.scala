import methane.Oscillator
import midi.MidiProc
import uart.{UART_rx, UART_tx}

object VerilogGen extends App {
  circt.stage.ChiselStage.emitSystemVerilogFile(new Oscillator,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )
  circt.stage.ChiselStage.emitSystemVerilogFile(new MidiProc,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )
  circt.stage.ChiselStage.emitSystemVerilogFile(new UART_tx,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )
  circt.stage.ChiselStage.emitSystemVerilogFile(new UART_rx,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )
}
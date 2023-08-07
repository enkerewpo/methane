import methane.Oscillator
import midi.MidiProc
import uart.{UART_rx, UART_tx}

object VerilogGen extends App {

  // Oscillator.sv
  circt.stage.ChiselStage.emitSystemVerilogFile(new Oscillator,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )

  // MidiProc.sv
  circt.stage.ChiselStage.emitSystemVerilogFile(new MidiProc,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )

  // UART_rx.sv
  circt.stage.ChiselStage.emitSystemVerilogFile(new UART_tx,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )

  // ADSR.sv
  circt.stage.ChiselStage.emitSystemVerilogFile(new methane.ADSR,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )

  // VCA.sv
  circt.stage.ChiselStage.emitSystemVerilogFile(new methane.VCA,
    Array("--target-dir", "output"),
    Array("--strip-debug-info"),
  )
}
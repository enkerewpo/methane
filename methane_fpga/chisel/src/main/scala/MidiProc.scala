import chisel3._


/**
 * MIDI processing module
 *
 * @author wheatfox
 * @version 20230305
 */

class MidiProc extends Module {



}

object MidiProcGen extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new MidiProc,
        Array("--target-dir", "output/")
    )
}
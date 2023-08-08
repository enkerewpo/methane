import chisel3._
import chiseltest._
import midi.MidiProc
import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.simulator.WriteVcdAnnotation

class MidiTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "MidiProc"

  it should "parse midi message" in {
    test(new MidiProc).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      c.io.en.poke(true.B)
      c.clock.step(100)
      // send serial data as midi message
      // baud rate: 31250
      // clock frequency: 10M
      // send note-on, channel 0, note A4, velocity 100
      // serial data: 0x90 0x45 0x64
      // serial data in binary: 10010000 01000101 01100100
      // TODO: run test
    }
  }
}
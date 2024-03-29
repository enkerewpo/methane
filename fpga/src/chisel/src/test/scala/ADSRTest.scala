import chisel3._
import chiseltest._
import methane.ADSR
import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.simulator.WriteVcdAnnotation

class ADSRTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ADSR"

  it should "output ADSR control signal" in {
    test(new ADSR).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      c.io.en.poke(true.B)
      c.io.attack_curve_type.poke(1.U)
      c.io.decay_curve_type.poke(2.U)
      c.io.release_curve_type.poke(0.U)
      c.io.attack.poke(100.U)
      c.io.decay.poke(100.U)
      c.io.sustain.poke(3500000000L.U)
      c.io.release.poke(100.U)
      c.clock.step(100)
      // note on
      c.io.note_on.poke(true.B)
      c.io.note_off.poke(false.B)
      c.clock.step(20)
      c.io.note_on.poke(false.B)
      // wait 300 clock cycles
      c.clock.step(300)
      // note off
      c.io.note_on.poke(false.B)
      c.io.note_off.poke(true.B)
      c.clock.step(20)
      c.io.note_off.poke(false.B)
      c.clock.step(200)
    }
  }
}
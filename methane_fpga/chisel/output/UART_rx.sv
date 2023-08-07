// Generated by CIRCT firtool-1.48.0
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

// Include register initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_REG_
    `define ENABLE_INITIAL_REG_
  `endif // not def ENABLE_INITIAL_REG_
`endif // not def SYNTHESIS

// Include rmemory initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_MEM_
    `define ENABLE_INITIAL_MEM_
  `endif // not def ENABLE_INITIAL_MEM_
`endif // not def SYNTHESIS

module UART_rx(
  input        clock,
               reset,
               io_i_serial_data,
  output       io_o_rx_done,
  output [7:0] io_o_data
);

  reg [7:0] clkCnterReg;
  reg [3:0] bitCnterReg;
  reg       outDataReg_0;
  reg       outDataReg_1;
  reg       outDataReg_2;
  reg       outDataReg_3;
  reg       outDataReg_4;
  reg       outDataReg_5;
  reg       outDataReg_6;
  reg       outDataReg_7;
  reg       outRxDoneReg;
  reg [1:0] stateReg;
  reg       serialDataReg_REG;
  reg       serialDataReg;
  always @(posedge clock) begin
    if (reset) begin
      clkCnterReg <= 8'h0;
      bitCnterReg <= 4'h0;
      outDataReg_0 <= 1'h0;
      outDataReg_1 <= 1'h0;
      outDataReg_2 <= 1'h0;
      outDataReg_3 <= 1'h0;
      outDataReg_4 <= 1'h0;
      outDataReg_5 <= 1'h0;
      outDataReg_6 <= 1'h0;
      outDataReg_7 <= 1'h0;
      outRxDoneReg <= 1'h0;
      stateReg <= 2'h0;
    end
    else begin
      automatic logic            _GEN;
      automatic logic            _GEN_0;
      automatic logic            _GEN_1;
      automatic logic            _GEN_2;
      automatic logic            _GEN_3;
      automatic logic            _GEN_4;
      automatic logic [3:0][7:0] _GEN_5;
      automatic logic [3:0][1:0] _GEN_6;
      _GEN = stateReg == 2'h0;
      _GEN_0 = stateReg == 2'h1;
      _GEN_1 = clkCnterReg < 8'h2B;
      _GEN_2 = stateReg == 2'h2;
      _GEN_3 = clkCnterReg < 8'h56;
      _GEN_4 = _GEN | _GEN_0;
      _GEN_5 =
        {{_GEN_3 ? clkCnterReg + 8'h1 : 8'h0},
         {_GEN_3 ? clkCnterReg + 8'h1 : 8'h0},
         {_GEN_1 ? clkCnterReg + 8'h1 : 8'h0},
         {8'h0}};
      clkCnterReg <= _GEN_5[stateReg];
      if (_GEN)
        bitCnterReg <= 4'h0;
      else if (_GEN_0 | ~_GEN_2 | _GEN_3) begin
      end
      else if (bitCnterReg[3])
        bitCnterReg <= 4'h0;
      else
        bitCnterReg <= bitCnterReg + 4'h1;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | (|(bitCnterReg[2:0]))) begin
      end
      else
        outDataReg_0 <= serialDataReg;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | bitCnterReg[2:0] != 3'h1) begin
      end
      else
        outDataReg_1 <= serialDataReg;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | bitCnterReg[2:0] != 3'h2) begin
      end
      else
        outDataReg_2 <= serialDataReg;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | bitCnterReg[2:0] != 3'h3) begin
      end
      else
        outDataReg_3 <= serialDataReg;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | bitCnterReg[2:0] != 3'h4) begin
      end
      else
        outDataReg_4 <= serialDataReg;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | bitCnterReg[2:0] != 3'h5) begin
      end
      else
        outDataReg_5 <= serialDataReg;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | bitCnterReg[2:0] != 3'h6) begin
      end
      else
        outDataReg_6 <= serialDataReg;
      if (_GEN_4 | ~_GEN_2 | _GEN_3 | bitCnterReg[2:0] != 3'h7) begin
      end
      else
        outDataReg_7 <= serialDataReg;
      outRxDoneReg <= ~_GEN & (~(_GEN_0 | _GEN_2) & (&stateReg) & ~_GEN_3 | outRxDoneReg);
      _GEN_6 =
        {{{2{_GEN_3}}},
         {{1'h1, bitCnterReg == 4'h8}},
         {_GEN_1 ? 2'h1 : {~serialDataReg, 1'h0}},
         {{1'h0, ~serialDataReg}}};
      stateReg <= _GEN_6[stateReg];
    end
    serialDataReg_REG <= io_i_serial_data;
    serialDataReg <= serialDataReg_REG;
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        clkCnterReg = _RANDOM[/*Zero width*/ 1'b0][7:0];
        bitCnterReg = _RANDOM[/*Zero width*/ 1'b0][11:8];
        outDataReg_0 = _RANDOM[/*Zero width*/ 1'b0][12];
        outDataReg_1 = _RANDOM[/*Zero width*/ 1'b0][13];
        outDataReg_2 = _RANDOM[/*Zero width*/ 1'b0][14];
        outDataReg_3 = _RANDOM[/*Zero width*/ 1'b0][15];
        outDataReg_4 = _RANDOM[/*Zero width*/ 1'b0][16];
        outDataReg_5 = _RANDOM[/*Zero width*/ 1'b0][17];
        outDataReg_6 = _RANDOM[/*Zero width*/ 1'b0][18];
        outDataReg_7 = _RANDOM[/*Zero width*/ 1'b0][19];
        outRxDoneReg = _RANDOM[/*Zero width*/ 1'b0][20];
        stateReg = _RANDOM[/*Zero width*/ 1'b0][22:21];
        serialDataReg_REG = _RANDOM[/*Zero width*/ 1'b0][23];
        serialDataReg = _RANDOM[/*Zero width*/ 1'b0][24];
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_o_rx_done = outRxDoneReg;
  assign io_o_data =
    {outDataReg_7,
     outDataReg_6,
     outDataReg_5,
     outDataReg_4,
     outDataReg_3,
     outDataReg_2,
     outDataReg_1,
     outDataReg_0};
endmodule

module UART_rx(
  input        clock,
  input        reset,
  input        io_i_serial_data,
  output       io_o_rx_done,
  output [7:0] io_o_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] clkCnterReg; // @[UART_rx.scala 25:28]
  reg [3:0] bitCnterReg; // @[UART_rx.scala 26:28]
  reg  outDataReg_0; // @[UART_rx.scala 28:27]
  reg  outDataReg_1; // @[UART_rx.scala 28:27]
  reg  outDataReg_2; // @[UART_rx.scala 28:27]
  reg  outDataReg_3; // @[UART_rx.scala 28:27]
  reg  outDataReg_4; // @[UART_rx.scala 28:27]
  reg  outDataReg_5; // @[UART_rx.scala 28:27]
  reg  outDataReg_6; // @[UART_rx.scala 28:27]
  reg  outDataReg_7; // @[UART_rx.scala 28:27]
  reg  outRxDoneReg; // @[UART_rx.scala 29:29]
  reg [1:0] stateReg; // @[UART_rx.scala 30:25]
  reg  serialDataReg_REG; // @[UART_rx.scala 33:38]
  reg  serialDataReg; // @[UART_rx.scala 33:30]
  wire [3:0] io_o_data_lo = {outDataReg_3,outDataReg_2,outDataReg_1,outDataReg_0}; // @[Cat.scala 33:92]
  wire [3:0] io_o_data_hi = {outDataReg_7,outDataReg_6,outDataReg_5,outDataReg_4}; // @[Cat.scala 33:92]
  wire  _T_1 = ~serialDataReg; // @[UART_rx.scala 45:27]
  wire [9:0] _clkCnterReg_T_1 = clkCnterReg + 10'h1; // @[UART_rx.scala 53:36]
  wire [1:0] _GEN_1 = _T_1 ? 2'h2 : 2'h0; // @[UART_rx.scala 58:42 59:20 62:20]
  wire  _T_6 = clkCnterReg < 10'h140; // @[UART_rx.scala 67:25]
  wire  _GEN_4 = 3'h0 == bitCnterReg[2:0] ? serialDataReg : outDataReg_0; // @[UART_rx.scala 28:27 73:{33,33}]
  wire  _GEN_5 = 3'h1 == bitCnterReg[2:0] ? serialDataReg : outDataReg_1; // @[UART_rx.scala 28:27 73:{33,33}]
  wire  _GEN_6 = 3'h2 == bitCnterReg[2:0] ? serialDataReg : outDataReg_2; // @[UART_rx.scala 28:27 73:{33,33}]
  wire  _GEN_7 = 3'h3 == bitCnterReg[2:0] ? serialDataReg : outDataReg_3; // @[UART_rx.scala 28:27 73:{33,33}]
  wire  _GEN_8 = 3'h4 == bitCnterReg[2:0] ? serialDataReg : outDataReg_4; // @[UART_rx.scala 28:27 73:{33,33}]
  wire  _GEN_9 = 3'h5 == bitCnterReg[2:0] ? serialDataReg : outDataReg_5; // @[UART_rx.scala 28:27 73:{33,33}]
  wire  _GEN_10 = 3'h6 == bitCnterReg[2:0] ? serialDataReg : outDataReg_6; // @[UART_rx.scala 28:27 73:{33,33}]
  wire  _GEN_11 = 3'h7 == bitCnterReg[2:0] ? serialDataReg : outDataReg_7; // @[UART_rx.scala 28:27 73:{33,33}]
  wire [3:0] _bitCnterReg_T_1 = bitCnterReg + 4'h1; // @[UART_rx.scala 75:38]
  wire [3:0] _GEN_12 = bitCnterReg < 4'h8 ? _bitCnterReg_T_1 : 4'h0; // @[UART_rx.scala 74:44 75:23 77:23]
  wire [9:0] _GEN_13 = clkCnterReg < 10'h140 ? _clkCnterReg_T_1 : 10'h0; // @[UART_rx.scala 67:41 68:21 70:21]
  wire  _GEN_14 = clkCnterReg < 10'h140 ? outDataReg_0 : _GEN_4; // @[UART_rx.scala 28:27 67:41]
  wire  _GEN_15 = clkCnterReg < 10'h140 ? outDataReg_1 : _GEN_5; // @[UART_rx.scala 28:27 67:41]
  wire  _GEN_16 = clkCnterReg < 10'h140 ? outDataReg_2 : _GEN_6; // @[UART_rx.scala 28:27 67:41]
  wire  _GEN_17 = clkCnterReg < 10'h140 ? outDataReg_3 : _GEN_7; // @[UART_rx.scala 28:27 67:41]
  wire  _GEN_18 = clkCnterReg < 10'h140 ? outDataReg_4 : _GEN_8; // @[UART_rx.scala 28:27 67:41]
  wire  _GEN_19 = clkCnterReg < 10'h140 ? outDataReg_5 : _GEN_9; // @[UART_rx.scala 28:27 67:41]
  wire  _GEN_20 = clkCnterReg < 10'h140 ? outDataReg_6 : _GEN_10; // @[UART_rx.scala 28:27 67:41]
  wire  _GEN_21 = clkCnterReg < 10'h140 ? outDataReg_7 : _GEN_11; // @[UART_rx.scala 28:27 67:41]
  wire [3:0] _GEN_22 = clkCnterReg < 10'h140 ? bitCnterReg : _GEN_12; // @[UART_rx.scala 26:28 67:41]
  wire [1:0] _GEN_23 = bitCnterReg == 4'h8 ? 2'h3 : 2'h2; // @[UART_rx.scala 80:44 81:18 83:18]
  wire [1:0] _GEN_25 = _T_6 ? 2'h3 : 2'h0; // @[UART_rx.scala 87:41 89:18 94:18]
  wire  _GEN_26 = _T_6 ? outRxDoneReg : 1'h1; // @[UART_rx.scala 29:29 87:41 93:22]
  wire [9:0] _GEN_27 = 2'h3 == stateReg ? _GEN_13 : clkCnterReg; // @[UART_rx.scala 38:21 25:28]
  wire [1:0] _GEN_28 = 2'h3 == stateReg ? _GEN_25 : stateReg; // @[UART_rx.scala 38:21 30:25]
  wire  _GEN_29 = 2'h3 == stateReg ? _GEN_26 : outRxDoneReg; // @[UART_rx.scala 38:21 29:29]
  assign io_o_rx_done = outRxDoneReg; // @[UART_rx.scala 36:16]
  assign io_o_data = {io_o_data_hi,io_o_data_lo}; // @[Cat.scala 33:92]
  always @(posedge clock) begin
    if (reset) begin // @[UART_rx.scala 25:28]
      clkCnterReg <= 10'h0; // @[UART_rx.scala 25:28]
    end else if (2'h0 == stateReg) begin // @[UART_rx.scala 38:21]
      clkCnterReg <= 10'h0; // @[UART_rx.scala 42:19]
    end else if (2'h1 == stateReg) begin // @[UART_rx.scala 38:21]
      if (clkCnterReg < 10'ha0) begin // @[UART_rx.scala 52:47]
        clkCnterReg <= _clkCnterReg_T_1; // @[UART_rx.scala 53:21]
      end else begin
        clkCnterReg <= 10'h0; // @[UART_rx.scala 57:21]
      end
    end else if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
      clkCnterReg <= _GEN_13;
    end else begin
      clkCnterReg <= _GEN_27;
    end
    if (reset) begin // @[UART_rx.scala 26:28]
      bitCnterReg <= 4'h0; // @[UART_rx.scala 26:28]
    end else if (2'h0 == stateReg) begin // @[UART_rx.scala 38:21]
      bitCnterReg <= 4'h0; // @[UART_rx.scala 43:19]
    end else if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
        bitCnterReg <= _GEN_22;
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_0 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_0 <= _GEN_14;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_1 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_1 <= _GEN_15;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_2 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_2 <= _GEN_16;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_3 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_3 <= _GEN_17;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_4 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_4 <= _GEN_18;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_5 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_5 <= _GEN_19;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_6 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_6 <= _GEN_20;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 28:27]
      outDataReg_7 <= 1'h0; // @[UART_rx.scala 28:27]
    end else if (!(2'h0 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
        if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
          outDataReg_7 <= _GEN_21;
        end
      end
    end
    if (reset) begin // @[UART_rx.scala 29:29]
      outRxDoneReg <= 1'h0; // @[UART_rx.scala 29:29]
    end else if (2'h0 == stateReg) begin // @[UART_rx.scala 38:21]
      outRxDoneReg <= 1'h0; // @[UART_rx.scala 40:20]
    end else if (!(2'h1 == stateReg)) begin // @[UART_rx.scala 38:21]
      if (!(2'h2 == stateReg)) begin // @[UART_rx.scala 38:21]
        outRxDoneReg <= _GEN_29;
      end
    end
    if (reset) begin // @[UART_rx.scala 30:25]
      stateReg <= 2'h0; // @[UART_rx.scala 30:25]
    end else if (2'h0 == stateReg) begin // @[UART_rx.scala 38:21]
      if (~serialDataReg) begin // @[UART_rx.scala 45:40]
        stateReg <= 2'h1; // @[UART_rx.scala 46:18]
      end else begin
        stateReg <= 2'h0; // @[UART_rx.scala 48:18]
      end
    end else if (2'h1 == stateReg) begin // @[UART_rx.scala 38:21]
      if (clkCnterReg < 10'ha0) begin // @[UART_rx.scala 52:47]
        stateReg <= 2'h1; // @[UART_rx.scala 54:18]
      end else begin
        stateReg <= _GEN_1;
      end
    end else if (2'h2 == stateReg) begin // @[UART_rx.scala 38:21]
      stateReg <= _GEN_23;
    end else begin
      stateReg <= _GEN_28;
    end
    serialDataReg_REG <= io_i_serial_data; // @[UART_rx.scala 33:38]
    serialDataReg <= serialDataReg_REG; // @[UART_rx.scala 33:30]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  clkCnterReg = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  bitCnterReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  outDataReg_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  outDataReg_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  outDataReg_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  outDataReg_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  outDataReg_4 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  outDataReg_5 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  outDataReg_6 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  outDataReg_7 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  outRxDoneReg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  stateReg = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  serialDataReg_REG = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  serialDataReg = _RAND_13[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MidiProc(
  input         clock,
  input         reset,
  input         io_en,
  input         io_midi_in,
  output [31:0] io_freq
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  uart_r_clock; // @[MidiProc.scala 21:24]
  wire  uart_r_reset; // @[MidiProc.scala 21:24]
  wire  uart_r_io_i_serial_data; // @[MidiProc.scala 21:24]
  wire  uart_r_io_o_rx_done; // @[MidiProc.scala 21:24]
  wire [7:0] uart_r_io_o_data; // @[MidiProc.scala 21:24]
  reg [7:0] byte_r; // @[MidiProc.scala 27:25]
  reg [1:0] state; // @[MidiProc.scala 33:24]
  reg [3:0] sbyte; // @[MidiProc.scala 40:24]
  reg [6:0] note; // @[MidiProc.scala 41:23]
  wire [31:0] _GEN_1 = 7'h1 == note ? 32'h362 : 32'h332; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_2 = 7'h2 == note ? 32'h396 : _GEN_1; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_3 = 7'h3 == note ? 32'h3cc : _GEN_2; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_4 = 7'h4 == note ? 32'h406 : _GEN_3; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_5 = 7'h5 == note ? 32'h443 : _GEN_4; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_6 = 7'h6 == note ? 32'h484 : _GEN_5; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_7 = 7'h7 == note ? 32'h4c9 : _GEN_6; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_8 = 7'h8 == note ? 32'h512 : _GEN_7; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_9 = 7'h9 == note ? 32'h55f : _GEN_8; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_10 = 7'ha == note ? 32'h5b1 : _GEN_9; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_11 = 7'hb == note ? 32'h607 : _GEN_10; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_12 = 7'hc == note ? 32'h663 : _GEN_11; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_13 = 7'hd == note ? 32'h6c4 : _GEN_12; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_14 = 7'he == note ? 32'h72b : _GEN_13; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_15 = 7'hf == note ? 32'h799 : _GEN_14; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_16 = 7'h10 == note ? 32'h80c : _GEN_15; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_17 = 7'h11 == note ? 32'h887 : _GEN_16; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_18 = 7'h12 == note ? 32'h908 : _GEN_17; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_19 = 7'h13 == note ? 32'h992 : _GEN_18; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_20 = 7'h14 == note ? 32'ha24 : _GEN_19; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_21 = 7'h15 == note ? 32'habe : _GEN_20; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_22 = 7'h16 == note ? 32'hb62 : _GEN_21; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_23 = 7'h17 == note ? 32'hc0f : _GEN_22; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_24 = 7'h18 == note ? 32'hcc6 : _GEN_23; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_25 = 7'h19 == note ? 32'hd89 : _GEN_24; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_26 = 7'h1a == note ? 32'he57 : _GEN_25; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_27 = 7'h1b == note ? 32'hf31 : _GEN_26; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_28 = 7'h1c == note ? 32'h1018 : _GEN_27; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_29 = 7'h1d == note ? 32'h110d : _GEN_28; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_30 = 7'h1e == note ? 32'h1211 : _GEN_29; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_31 = 7'h1f == note ? 32'h1324 : _GEN_30; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_32 = 7'h20 == note ? 32'h1447 : _GEN_31; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_33 = 7'h21 == note ? 32'h157c : _GEN_32; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_34 = 7'h22 == note ? 32'h16c3 : _GEN_33; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_35 = 7'h23 == note ? 32'h181e : _GEN_34; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_36 = 7'h24 == note ? 32'h198d : _GEN_35; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_37 = 7'h25 == note ? 32'h1b12 : _GEN_36; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_38 = 7'h26 == note ? 32'h1cae : _GEN_37; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_39 = 7'h27 == note ? 32'h1e62 : _GEN_38; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_40 = 7'h28 == note ? 32'h2031 : _GEN_39; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_41 = 7'h29 == note ? 32'h221b : _GEN_40; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_42 = 7'h2a == note ? 32'h2422 : _GEN_41; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_43 = 7'h2b == note ? 32'h2648 : _GEN_42; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_44 = 7'h2c == note ? 32'h288f : _GEN_43; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_45 = 7'h2d == note ? 32'h2af8 : _GEN_44; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_46 = 7'h2e == note ? 32'h2d86 : _GEN_45; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_47 = 7'h2f == note ? 32'h303b : _GEN_46; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_48 = 7'h30 == note ? 32'h3319 : _GEN_47; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_49 = 7'h31 == note ? 32'h3623 : _GEN_48; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_50 = 7'h32 == note ? 32'h395b : _GEN_49; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_51 = 7'h33 == note ? 32'h3cc4 : _GEN_50; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_52 = 7'h34 == note ? 32'h4061 : _GEN_51; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_53 = 7'h35 == note ? 32'h4435 : _GEN_52; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_54 = 7'h36 == note ? 32'h4844 : _GEN_53; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_55 = 7'h37 == note ? 32'h4c90 : _GEN_54; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_56 = 7'h38 == note ? 32'h511d : _GEN_55; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_57 = 7'h39 == note ? 32'h55f0 : _GEN_56; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_58 = 7'h3a == note ? 32'h5b0c : _GEN_57; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_59 = 7'h3b == note ? 32'h6076 : _GEN_58; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_60 = 7'h3c == note ? 32'h6633 : _GEN_59; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_61 = 7'h3d == note ? 32'h6c46 : _GEN_60; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_62 = 7'h3e == note ? 32'h72b6 : _GEN_61; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_63 = 7'h3f == note ? 32'h7989 : _GEN_62; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_64 = 7'h40 == note ? 32'h80c3 : _GEN_63; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_65 = 7'h41 == note ? 32'h886b : _GEN_64; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_66 = 7'h42 == note ? 32'h9087 : _GEN_65; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_67 = 7'h43 == note ? 32'h9920 : _GEN_66; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_68 = 7'h44 == note ? 32'ha23a : _GEN_67; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_69 = 7'h45 == note ? 32'habe0 : _GEN_68; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_70 = 7'h46 == note ? 32'hb618 : _GEN_69; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_71 = 7'h47 == note ? 32'hc0ec : _GEN_70; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_72 = 7'h48 == note ? 32'hcc65 : _GEN_71; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_73 = 7'h49 == note ? 32'hd88d : _GEN_72; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_74 = 7'h4a == note ? 32'he56d : _GEN_73; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_75 = 7'h4b == note ? 32'hf311 : _GEN_74; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_76 = 7'h4c == note ? 32'h10186 : _GEN_75; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_77 = 7'h4d == note ? 32'h110d6 : _GEN_76; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_78 = 7'h4e == note ? 32'h1210f : _GEN_77; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_79 = 7'h4f == note ? 32'h1323f : _GEN_78; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_80 = 7'h50 == note ? 32'h14475 : _GEN_79; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_81 = 7'h51 == note ? 32'h157c0 : _GEN_80; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_82 = 7'h52 == note ? 32'h16c31 : _GEN_81; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_83 = 7'h53 == note ? 32'h181d9 : _GEN_82; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_84 = 7'h54 == note ? 32'h198ca : _GEN_83; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_85 = 7'h55 == note ? 32'h1b119 : _GEN_84; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_86 = 7'h56 == note ? 32'h1cada : _GEN_85; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_87 = 7'h57 == note ? 32'h1e623 : _GEN_86; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_88 = 7'h58 == note ? 32'h2030b : _GEN_87; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_89 = 7'h59 == note ? 32'h221ab : _GEN_88; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_90 = 7'h5a == note ? 32'h2421e : _GEN_89; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_91 = 7'h5b == note ? 32'h2647e : _GEN_90; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_92 = 7'h5c == note ? 32'h288ea : _GEN_91; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_93 = 7'h5d == note ? 32'h2af80 : _GEN_92; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_94 = 7'h5e == note ? 32'h2d862 : _GEN_93; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_95 = 7'h5f == note ? 32'h303b1 : _GEN_94; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_96 = 7'h60 == note ? 32'h33194 : _GEN_95; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_97 = 7'h61 == note ? 32'h36232 : _GEN_96; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_98 = 7'h62 == note ? 32'h395b4 : _GEN_97; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_99 = 7'h63 == note ? 32'h3cc46 : _GEN_98; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_100 = 7'h64 == note ? 32'h40616 : _GEN_99; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_101 = 7'h65 == note ? 32'h44357 : _GEN_100; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_102 = 7'h66 == note ? 32'h4843c : _GEN_101; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_103 = 7'h67 == note ? 32'h4c8fc : _GEN_102; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_104 = 7'h68 == note ? 32'h511d4 : _GEN_103; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_105 = 7'h69 == note ? 32'h55f00 : _GEN_104; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_106 = 7'h6a == note ? 32'h5b0c3 : _GEN_105; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_107 = 7'h6b == note ? 32'h60763 : _GEN_106; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_108 = 7'h6c == note ? 32'h66329 : _GEN_107; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_109 = 7'h6d == note ? 32'h6c464 : _GEN_108; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_110 = 7'h6e == note ? 32'h72b68 : _GEN_109; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_111 = 7'h6f == note ? 32'h7988b : _GEN_110; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_112 = 7'h70 == note ? 32'h80c2c : _GEN_111; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_113 = 7'h71 == note ? 32'h886ad : _GEN_112; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_114 = 7'h72 == note ? 32'h90877 : _GEN_113; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_115 = 7'h73 == note ? 32'h991f9 : _GEN_114; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_116 = 7'h74 == note ? 32'ha23a8 : _GEN_115; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_117 = 7'h75 == note ? 32'habe00 : _GEN_116; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_118 = 7'h76 == note ? 32'hb6186 : _GEN_117; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_119 = 7'h77 == note ? 32'hc0ec5 : _GEN_118; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_120 = 7'h78 == note ? 32'hcc652 : _GEN_119; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_121 = 7'h79 == note ? 32'hd88c8 : _GEN_120; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_122 = 7'h7a == note ? 32'he56cf : _GEN_121; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_123 = 7'h7b == note ? 32'hf3116 : _GEN_122; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_124 = 7'h7c == note ? 32'h101858 : _GEN_123; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_125 = 7'h7d == note ? 32'h110d5a : _GEN_124; // @[MidiProc.scala 50:{13,13}]
  wire [31:0] _GEN_126 = 7'h7e == note ? 32'h1210ee : _GEN_125; // @[MidiProc.scala 50:{13,13}]
  wire  byte_ok = uart_r_io_o_rx_done; // @[MidiProc.scala 26:23 30:13]
  wire [7:0] _GEN_128 = byte_ok ? uart_r_io_o_data : byte_r; // @[MidiProc.scala 57:27 58:24 27:25]
  wire [7:0] _GEN_130 = byte_ok ? byte_r : {{4'd0}, sbyte}; // @[MidiProc.scala 57:27 60:23 40:24]
  wire  _T_2 = 4'h9 == sbyte; // @[MidiProc.scala 66:31]
  wire [7:0] _GEN_131 = 4'h9 == sbyte ? byte_r : {{1'd0}, note}; // @[MidiProc.scala 41:23 66:31 68:30]
  wire [1:0] _GEN_132 = 4'h9 == sbyte ? 2'h2 : state; // @[MidiProc.scala 33:24 66:31 69:31]
  wire [7:0] _GEN_133 = byte_ok ? _GEN_131 : {{1'd0}, note}; // @[MidiProc.scala 41:23 64:27]
  wire [1:0] _GEN_136 = _T_2 ? 2'h0 : state; // @[MidiProc.scala 33:24 77:31 83:31]
  wire [1:0] _GEN_138 = byte_ok ? _GEN_136 : state; // @[MidiProc.scala 33:24 75:27]
  wire [7:0] _GEN_143 = 2'h1 == state ? _GEN_133 : {{1'd0}, note}; // @[MidiProc.scala 55:19 41:23]
  wire [7:0] _GEN_148 = 2'h0 == state ? _GEN_130 : {{4'd0}, sbyte}; // @[MidiProc.scala 55:19 40:24]
  wire [7:0] _GEN_149 = 2'h0 == state ? {{1'd0}, note} : _GEN_143; // @[MidiProc.scala 55:19 41:23]
  wire [7:0] _GEN_151 = reset ? 8'h0 : _GEN_148; // @[MidiProc.scala 40:{24,24}]
  wire [7:0] _GEN_152 = reset ? 8'h0 : _GEN_149; // @[MidiProc.scala 41:{23,23}]
  UART_rx uart_r ( // @[MidiProc.scala 21:24]
    .clock(uart_r_clock),
    .reset(uart_r_reset),
    .io_i_serial_data(uart_r_io_i_serial_data),
    .io_o_rx_done(uart_r_io_o_rx_done),
    .io_o_data(uart_r_io_o_data)
  );
  assign io_freq = 7'h7f == note ? 32'h1323f1 : _GEN_126; // @[MidiProc.scala 50:{13,13}]
  assign uart_r_clock = clock;
  assign uart_r_reset = reset;
  assign uart_r_io_i_serial_data = io_midi_in; // @[MidiProc.scala 29:29]
  always @(posedge clock) begin
    if (reset) begin // @[MidiProc.scala 27:25]
      byte_r <= 8'h0; // @[MidiProc.scala 27:25]
    end else if (2'h0 == state) begin // @[MidiProc.scala 55:19]
      byte_r <= _GEN_128;
    end else if (2'h1 == state) begin // @[MidiProc.scala 55:19]
      byte_r <= _GEN_128;
    end else if (2'h2 == state) begin // @[MidiProc.scala 55:19]
      byte_r <= _GEN_128;
    end
    if (reset) begin // @[MidiProc.scala 33:24]
      state <= 2'h0; // @[MidiProc.scala 33:24]
    end else if (2'h0 == state) begin // @[MidiProc.scala 55:19]
      if (byte_ok) begin // @[MidiProc.scala 57:27]
        state <= 2'h1; // @[MidiProc.scala 59:23]
      end
    end else if (2'h1 == state) begin // @[MidiProc.scala 55:19]
      if (byte_ok) begin // @[MidiProc.scala 64:27]
        state <= _GEN_132;
      end
    end else if (2'h2 == state) begin // @[MidiProc.scala 55:19]
      state <= _GEN_138;
    end
    sbyte <= _GEN_151[3:0]; // @[MidiProc.scala 40:{24,24}]
    note <= _GEN_152[6:0]; // @[MidiProc.scala 41:{23,23}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  byte_r = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  state = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  sbyte = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  note = _RAND_3[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

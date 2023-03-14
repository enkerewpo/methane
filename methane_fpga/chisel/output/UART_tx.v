module UART_tx(
  input        clock,
  input        reset,
  input        io_i_tx_trig,
  input  [7:0] io_i_data,
  output       io_o_tx_busy,
  output       io_o_tx_done,
  output       io_o_serial_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] clkCnterReg; // @[UART_tx.scala 27:28]
  reg [3:0] bitCnterReg; // @[UART_tx.scala 28:28]
  reg [7:0] inDataReg; // @[UART_tx.scala 30:26]
  reg  outDataReg; // @[UART_tx.scala 31:27]
  reg  outTxBusyReg; // @[UART_tx.scala 32:29]
  reg  outTxDoneReg; // @[UART_tx.scala 33:29]
  reg [1:0] stateReg; // @[UART_tx.scala 34:25]
  wire  _GEN_0 = io_i_tx_trig ? 1'h0 : outDataReg; // @[UART_tx.scala 48:38 49:20 31:27]
  wire  _T_3 = clkCnterReg < 8'h56; // @[UART_tx.scala 58:25]
  wire [7:0] _clkCnterReg_T_1 = clkCnterReg + 8'h1; // @[UART_tx.scala 59:36]
  wire [3:0] _bitCnterReg_T_1 = bitCnterReg + 4'h1; // @[UART_tx.scala 63:36]
  wire [7:0] _outDataReg_T = inDataReg >> bitCnterReg; // @[UART_tx.scala 65:32]
  wire [7:0] _GEN_3 = clkCnterReg < 8'h56 ? _clkCnterReg_T_1 : 8'h0; // @[UART_tx.scala 58:41 59:21 62:21]
  wire  _GEN_6 = clkCnterReg < 8'h56 ? outDataReg : _outDataReg_T[0]; // @[UART_tx.scala 31:27 58:41 65:20]
  wire  _GEN_7 = bitCnterReg < 4'h8 ? _outDataReg_T[0] : 1'h1; // @[UART_tx.scala 75:44 77:22 83:22]
  wire [3:0] _GEN_8 = bitCnterReg < 4'h8 ? _bitCnterReg_T_1 : 4'h0; // @[UART_tx.scala 75:44 78:23 81:23]
  wire [1:0] _GEN_9 = bitCnterReg < 4'h8 ? 2'h2 : 2'h3; // @[UART_tx.scala 75:44 79:20 84:20]
  wire [1:0] _GEN_11 = _T_3 ? 2'h2 : _GEN_9; // @[UART_tx.scala 70:41 72:18]
  wire  _GEN_12 = _T_3 ? outDataReg : _GEN_7; // @[UART_tx.scala 31:27 70:41]
  wire [3:0] _GEN_13 = _T_3 ? bitCnterReg : _GEN_8; // @[UART_tx.scala 28:28 70:41]
  wire [1:0] _GEN_15 = _T_3 ? 2'h3 : 2'h0; // @[UART_tx.scala 89:41 91:18 95:18]
  wire  _GEN_16 = _T_3 ? outTxDoneReg : 1'h1; // @[UART_tx.scala 33:29 89:41 94:22]
  wire [7:0] _GEN_17 = 2'h3 == stateReg ? _GEN_3 : clkCnterReg; // @[UART_tx.scala 41:21 27:28]
  wire [1:0] _GEN_18 = 2'h3 == stateReg ? _GEN_15 : stateReg; // @[UART_tx.scala 41:21 34:25]
  wire  _GEN_19 = 2'h3 == stateReg ? _GEN_16 : outTxDoneReg; // @[UART_tx.scala 41:21 33:29]
  wire  _GEN_22 = 2'h2 == stateReg ? _GEN_12 : outDataReg; // @[UART_tx.scala 41:21 31:27]
  wire  _GEN_28 = 2'h1 == stateReg ? _GEN_6 : _GEN_22; // @[UART_tx.scala 41:21]
  wire  _GEN_33 = 2'h0 == stateReg ? _GEN_0 : _GEN_28; // @[UART_tx.scala 41:21]
  assign io_o_tx_busy = outTxBusyReg; // @[UART_tx.scala 37:16]
  assign io_o_tx_done = outTxDoneReg; // @[UART_tx.scala 38:16]
  assign io_o_serial_data = outDataReg; // @[UART_tx.scala 36:20]
  always @(posedge clock) begin
    if (reset) begin // @[UART_tx.scala 27:28]
      clkCnterReg <= 8'h0; // @[UART_tx.scala 27:28]
    end else if (2'h0 == stateReg) begin // @[UART_tx.scala 41:21]
      clkCnterReg <= 8'h0; // @[UART_tx.scala 45:19]
    end else if (2'h1 == stateReg) begin // @[UART_tx.scala 41:21]
      clkCnterReg <= _GEN_3;
    end else if (2'h2 == stateReg) begin // @[UART_tx.scala 41:21]
      clkCnterReg <= _GEN_3;
    end else begin
      clkCnterReg <= _GEN_17;
    end
    if (reset) begin // @[UART_tx.scala 28:28]
      bitCnterReg <= 4'h0; // @[UART_tx.scala 28:28]
    end else if (2'h0 == stateReg) begin // @[UART_tx.scala 41:21]
      bitCnterReg <= 4'h0; // @[UART_tx.scala 46:19]
    end else if (2'h1 == stateReg) begin // @[UART_tx.scala 41:21]
      if (!(clkCnterReg < 8'h56)) begin // @[UART_tx.scala 58:41]
        bitCnterReg <= _bitCnterReg_T_1; // @[UART_tx.scala 63:21]
      end
    end else if (2'h2 == stateReg) begin // @[UART_tx.scala 41:21]
      bitCnterReg <= _GEN_13;
    end
    if (reset) begin // @[UART_tx.scala 30:26]
      inDataReg <= 8'h0; // @[UART_tx.scala 30:26]
    end else if (2'h0 == stateReg) begin // @[UART_tx.scala 41:21]
      if (io_i_tx_trig) begin // @[UART_tx.scala 48:38]
        inDataReg <= io_i_data; // @[UART_tx.scala 51:19]
      end
    end
    outDataReg <= reset | _GEN_33; // @[UART_tx.scala 31:{27,27}]
    if (reset) begin // @[UART_tx.scala 32:29]
      outTxBusyReg <= 1'h0; // @[UART_tx.scala 32:29]
    end else begin
      outTxBusyReg <= stateReg != 2'h0; // @[UART_tx.scala 39:16]
    end
    if (reset) begin // @[UART_tx.scala 33:29]
      outTxDoneReg <= 1'h0; // @[UART_tx.scala 33:29]
    end else if (2'h0 == stateReg) begin // @[UART_tx.scala 41:21]
      outTxDoneReg <= 1'h0; // @[UART_tx.scala 43:20]
    end else if (!(2'h1 == stateReg)) begin // @[UART_tx.scala 41:21]
      if (!(2'h2 == stateReg)) begin // @[UART_tx.scala 41:21]
        outTxDoneReg <= _GEN_19;
      end
    end
    if (reset) begin // @[UART_tx.scala 34:25]
      stateReg <= 2'h0; // @[UART_tx.scala 34:25]
    end else if (2'h0 == stateReg) begin // @[UART_tx.scala 41:21]
      if (io_i_tx_trig) begin // @[UART_tx.scala 48:38]
        stateReg <= 2'h1; // @[UART_tx.scala 52:18]
      end else begin
        stateReg <= 2'h0; // @[UART_tx.scala 54:18]
      end
    end else if (2'h1 == stateReg) begin // @[UART_tx.scala 41:21]
      if (clkCnterReg < 8'h56) begin // @[UART_tx.scala 58:41]
        stateReg <= 2'h1; // @[UART_tx.scala 60:18]
      end else begin
        stateReg <= 2'h2; // @[UART_tx.scala 66:18]
      end
    end else if (2'h2 == stateReg) begin // @[UART_tx.scala 41:21]
      stateReg <= _GEN_11;
    end else begin
      stateReg <= _GEN_18;
    end
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
  clkCnterReg = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  bitCnterReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  inDataReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  outDataReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  outTxBusyReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  outTxDoneReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stateReg = _RAND_6[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

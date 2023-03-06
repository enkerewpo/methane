module I2S(
  input         clock,
  input         reset,
  input  [15:0] io_leftChannel,
  input  [15:0] io_rightChannel,
  output        io_bitClock,
  output        io_wordSelect,
  output        io_serialData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] bitCounter; // @[I2S.scala 15:29]
  wire [31:0] interleavedData = {io_rightChannel,io_leftChannel}; // @[Cat.scala 33:92]
  reg  bitClock; // @[I2S.scala 21:27]
  wire [3:0] _bitCounter_T_1 = bitCounter + 4'h1; // @[I2S.scala 26:34]
  reg  wordSelect; // @[I2S.scala 30:29]
  wire  _T_1 = bitCounter == 4'h0; // @[I2S.scala 31:21]
  reg  serialData; // @[I2S.scala 36:29]
  wire  _GEN_3 = bitCounter == 4'hf | serialData; // @[I2S.scala 39:37 40:20 36:29]
  wire [3:0] _io_serialData_T_2 = 4'hf - bitCounter; // @[I2S.scala 46:79]
  wire [31:0] _io_serialData_T_3 = interleavedData >> _io_serialData_T_2; // @[I2S.scala 46:74]
  assign io_bitClock = bitClock; // @[I2S.scala 44:17]
  assign io_wordSelect = wordSelect; // @[I2S.scala 45:19]
  assign io_serialData = serialData ? interleavedData[0] : ~_io_serialData_T_3[0]; // @[I2S.scala 46:25]
  always @(posedge clock) begin
    if (reset) begin // @[I2S.scala 15:29]
      bitCounter <= 4'h0; // @[I2S.scala 15:29]
    end else if (bitCounter == 4'h7) begin // @[I2S.scala 22:30]
      bitCounter <= 4'h0; // @[I2S.scala 24:20]
    end else begin
      bitCounter <= _bitCounter_T_1; // @[I2S.scala 26:20]
    end
    if (reset) begin // @[I2S.scala 21:27]
      bitClock <= 1'h0; // @[I2S.scala 21:27]
    end else if (bitCounter == 4'h7) begin // @[I2S.scala 22:30]
      bitClock <= ~bitClock; // @[I2S.scala 23:18]
    end
    if (reset) begin // @[I2S.scala 30:29]
      wordSelect <= 1'h0; // @[I2S.scala 30:29]
    end else if (bitCounter == 4'h0) begin // @[I2S.scala 31:30]
      wordSelect <= ~wordSelect; // @[I2S.scala 32:20]
    end
    if (reset) begin // @[I2S.scala 36:29]
      serialData <= 1'h0; // @[I2S.scala 36:29]
    end else if (_T_1) begin // @[I2S.scala 37:30]
      serialData <= 1'h0; // @[I2S.scala 38:20]
    end else begin
      serialData <= _GEN_3;
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
  bitCounter = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  bitClock = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  wordSelect = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  serialData = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

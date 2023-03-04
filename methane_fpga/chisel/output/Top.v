module Top(
  input         clock,
  input         reset,
  output [15:0] io_out
);
  assign io_out = 16'h3f35; // @[Top.scala 13:12]
endmodule

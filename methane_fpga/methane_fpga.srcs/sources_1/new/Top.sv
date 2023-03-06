module Top(
    input           clk_in_50M,
    input           rst,
    output          bclk,
    output          ws,
    output          d
    );

    logic clk_10M;
    logic clk_14M; // 14.1

    clk_wiz_0 cw0(
        .clk_in1(clk_in_50M),
        .reset(rst),
        .clk_out1(clk_10M),
        .clk_out2(clk_14M),
        .locked()
    );

    logic [15:0] out1;

    Oscillator osc1(
        .clock(clk_10M),
        .reset(rst),
        .io_en(1),
        .io_freq(32'd44000), // A440
        .io_out(out1)
    );

    I2S i2s(
        .clk(clk_14M),
        .rst(rst),
        .L(out1),
        .R(out1),
        .bclk(bclk),
        .ws(ws),
        .d(d)
    );

endmodule

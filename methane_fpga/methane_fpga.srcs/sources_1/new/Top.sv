module Top(
    input           clk_in_50M,
    input           rst,
    output  [15:0]  out
    );

    logic clk_10M;

    clk_wiz_0 cw0(
        .clk_in1(clk_in_50M),
        .reset(rst),
        .clk_out1(clk_10M),
        .locked()
    );

    Oscillator osc1(
        .clock(clk_10M),
        .reset(rst),
        .io_en(1),
        .io_freq(16'd440), // A440
        .io_out(out)
    );

endmodule

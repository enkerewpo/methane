`timescale 1ns / 1ps


module Top_tb();

    logic clk = 1'b0;
    logic rst = 1'b0;
    logic [15:0] out;

    always #10 clk = ~clk; // 50M -> 20ns

    initial begin
        #500 rst = 1'b1;
        #100 rst = 1'b0;
    end

    Top methane_top(
        .clk_in_50M(clk),
        .rst(rst),
        .out(out)
    );

endmodule

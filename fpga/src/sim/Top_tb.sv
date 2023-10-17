`timescale 1ns / 1ps


module Top_tb();

    logic clk = 1'b0;
    logic rst = 1'b1;
    logic [15:0] out;
    logic btn_k2 = 1'b1;

    always #10 clk = ~clk; // 50M -> 20ns

    initial begin
        #500 rst = 1'b0;
        #100 rst = 1'b1;
        #100 btn_k2 = 1'b0;
        // #100 btn_k2 = 1'b1;
    end

    Top methane_top(
        .clk_in_50M(clk),
        .btn_k2(btn_k2),
        .rst(rst)
    );

endmodule

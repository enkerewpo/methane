`timescale 1ns / 1ps


module Top_tb();

    logic clk = 1'b0;
    logic rst = 1'b0;
    logic [15:0] out;

    logic note_on = 1'b0;
    logic note_off = 1'b0;
    logic [15:0] adsr_cv;

    always #10 clk = ~clk; // 50M -> 20ns

    initial begin
        #500 rst = 1'b1;
        #100 rst = 1'b0;
        // simulated note-on event
        #10000
        #2000 note_on = 1'b1;
        #50 note_on = 1'b0;
        // simulated note-off event
        #4000 note_off = 1'b1;
        #50 note_off = 1'b0;
    end

    Top methane_top(
        .clk_in_50M(clk),
        .rst(rst),
        .debug_note_on(note_on),
        .debug_note_off(note_off),
        .debug_adsr_cv(adsr_cv)
    );

endmodule

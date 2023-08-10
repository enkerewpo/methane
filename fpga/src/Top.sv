module Top(
    input           clk_in_50M,
    input           rst,
    input           midi_rxd,
    output          bclk,
    output          ws,
    output          d,
    output          txd
    );

    logic clk_10M;
    logic clk_14M; // 14.1

    // Xilinx IP for clock generation
    clk_wiz_0 cw0(
        .clk_in1(clk_in_50M),
        .reset(rst),
        .clk_out1(clk_10M),
        .clk_out2(clk_14M),
        .locked()
    );

    logic [15:0] out1;
    logic [32:0] freq;
    logic note_on;
    logic note_off;

    MidiProc midi_proc(
        .clock(clk_10M),
        .reset(rst),
        .io_en(1),
        .io_midi_in(midi_rxd),
        .io_freq(freq),
        .io_note_on(note_on),
        .io_note_off(note_off)
    );

    logic [31:0] adsr_cv;

    ADSR adsr(
        .clock(clk_10M),
        .reset(rst),
        .io_en(1),
        .io_note_on(note_on),
        .io_note_off(note_off),
        .io_out(adsr_cv)
    );

    Oscillator osc1(
        .clock(clk_10M),
        .reset(rst),
        .io_en(1),
        .io_freq(freq), // A440
        .io_out(out1)
    );

    logic [15:0] out_after_vca;
    VCA vca(
        .clock(clk_10M),
        .reset(rst),
        .io_en(1),
        .io_in(out1),
        .io_control(adsr_cv),
        .io_out(out_after_vca)
    );

    I2S i2s(
        .clk(clk_14M),
        .rst(rst),
        .L(out_after_vca),
        .R(out_after_vca),
        .bclk(bclk),
        .ws(ws),
        .d(d)
    );

    UART_tx uart_tx(
        .clock(clk_10M),
        .reset(rst),
        .io_i_tx_trig(),
        .io_i_data(),
        .io_o_tx_busy(),
        .io_o_tx_done(),
        .io_o_serial_data(txd)
    );

endmodule

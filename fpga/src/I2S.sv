module I2S(
    input           clk,
    input           rst,
    input   [15:0]  L,
    input   [15:0]  R,
    output          bclk,
    output          ws,
    output          d
);

    logic [3:0] cnt1;
    logic bclk_r;
    logic ws_r;
    logic d_r;

    // cnt1
    always @(posedge clk, posedge rst) begin
        if(rst) 
            cnt1 <= 4'd0;
        else if(cnt1 == 4'd9) 
            cnt1 <= 4'd0;
        else 
            cnt1 <= cnt1 + 4'd1;
    end

    // bclk_r
    always @(posedge clk, posedge rst) begin
        if(rst) 
            bclk_r <= 1'b0;
        else if(cnt1 == 4'd9) 
            bclk_r <= ~bclk_r;
    end

    logic [4:0] bit_cnt;
    logic [15:0] L_r;
    logic [15:0] R_r;

    // bit_cnt
    always @(posedge bclk_r, posedge rst) begin
        if(rst)
            bit_cnt <= 0;
        else if(bit_cnt == 5'd31)
            bit_cnt <= 0;
        else
            bit_cnt <= bit_cnt + 1;
    end

    // L_r
    always @(posedge bclk_r, posedge rst) begin
        if(rst) L_r <= 0;
        else if(bit_cnt == 5'd31) L_r <= L;
    end

    // R_r
    always @(posedge bclk_r, posedge rst) begin
        if(rst) R_r <= 0;
        else if(bit_cnt == 5'd31) R_r <= R;
    end

    // ws_r
    always @(posedge bclk_r, posedge rst) begin
        if(rst) ws_r <= 0;
        else if(bit_cnt == 5'd31) ws_r <= 0;
        else if(bit_cnt == 5'd15) ws_r <= 1;
    end

    // d_r
    always @(posedge bclk_r, posedge rst) begin
        if(rst) d_r <= 0;
        else if(bit_cnt <= 5'd15) d_r <= L_r[5'd15 - bit_cnt];
        else d_r <= R_r[5'd31 - bit_cnt];
    end

    assign bclk = bclk_r;
    assign ws = ws_r;
    assign d = d_r;

endmodule
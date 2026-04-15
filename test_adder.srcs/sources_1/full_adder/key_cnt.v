module key_cnt(
    input key0_in,
    input key1_in,
    input clk,
    input reset_n,
    output wire [2:0] cnt_sel,
    output wire [7:0] seg
    );
    reg [15:0] key0_cnt = 16'h0;
    reg [2:0] sel;
    reg [11:0] sum_in = 12'h0;
    wire [1:0] key0,key1;
    wire key0_press;
    wire key1_press;
    wire [11:0] result;
    
    key_filter a0(.clk(clk),.rst(~reset_n),.key_in(key0_in),.key_out_s(key0[0]),.key_out_f(key0[1]));
    key_filter a1(.clk(clk),.rst(~reset_n),.key_in(key1_in),.key_out_s(key1[0]),.key_out_f(key1[1]));
    
    assign key0_press = key0[1] & (~key0[0]);
    assign key1_press = key1[1] & (~key1[0]);

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n) begin
            sel <= 3'd0;
            sum_in <= 12'd0;
            key0_cnt <= 16'h0;
        end
        else begin
            if(key1_press) begin
                if(sel < 4) 
                    sel <= sel + 1;
                else
                    sel <= 0;
            end

            if(key0_press) begin
                if(sel == 0) begin
                    if(key0_cnt[3:0] < 9)
                        key0_cnt[3:0] <= key0_cnt[3:0] + 1;
                    else
                        key0_cnt[3:0] <= 0;
                end
                else if(sel == 1) begin
                    if(key0_cnt[7:4] < 9)
                        key0_cnt[7:4] <= key0_cnt[7:4] + 1;
                    else
                        key0_cnt[7:4] <= 0;
                end
                else if(sel == 2) begin
                    if(key0_cnt[11:8] < 9)
                        key0_cnt[11:8] <= key0_cnt[11:8] + 1;
                    else
                        key0_cnt[11:8] <= 0;
                end
                else if(sel == 3) begin
                    if(key0_cnt[15:12] < 9)
                        key0_cnt[15:12] <= key0_cnt[15:12] + 1;
                    else
                        key0_cnt[15:12] <= 0;
                end
            end

            if(sel < 2)
                sum_in <= key0_cnt[7:0];
            else if(sel < 4)
                sum_in <= key0_cnt[15:8];
            else
                sum_in <= result;
        end
    end
    wire [7:0] a,b;
    
    bcd2bin u1(.indata(key0_cnt[7:0]),.outdata(a));
    bcd2bin u2(.indata(key0_cnt[15:8]),.outdata(b));
    key_adder u3(.clk(clk),.reset_n(reset_n),.a(a),.b(b),.q(result),.adder_en(sel[2]));
    seg8 u4(.clk(clk),.reset_n(reset_n),.seg_data(sum_in),.cnt_sel(cnt_sel),.seg(seg));     //按4次key1以后，进行加法运算
    
endmodule
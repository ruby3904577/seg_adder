module key_cnt(
    input key0_in,
    input key1_in,
    input clk,
    input reset_n,
    output wire [2:0] cnt_sel,
    output wire [7:0] seg
    );
    reg [4:0] key0_cnt = 0;
    reg [2:0] sel;
    reg [31:0] sum = 32'h0;
    wire key0,key1;
    
    key_filter a0(.clk(clk),.rst(~reset_n),.key_in(key0_in),.key_out(key0));
    key_filter a1(.clk(clk),.rst(~reset_n),.key_in(key1_in),.key_out(key1));
    
    always @(posedge key1) begin
        if(!reset_n)
            sel <= 1'b0;
        else if(sel<3)begin
            sel <= sel + 1;
            key0_cnt <= 0;
        end
        else
            sel <= 0;            
    end
    
    always @(posedge key0) begin
        if(!reset_n)
            key0_cnt <= 0;
        else if(key0_cnt < 15)
            key0_cnt <= key0_cnt + 1;
        else
            key0_cnt <= 0;
        case(sel)
            0: sum[3:0] <= key0_cnt;
            1: sum[7:4] <= key0_cnt;
            2: sum[11:8] <= key0_cnt;
            3: sum[15:12] <= key0_cnt;
        endcase
    end        
    
    seg8 u1(.clk(clk),.reset_n(reset_n),.seg_data(sum),.cnt_sel(cnt_sel),.seg(seg));
    //num_input u1(.sel(sel),.sum(key0_cnt)); //按5次key1以后，进行加法运算
    
endmodule
`timescale 1ns/1ps
module seg8(
    input clk,
    input reset_n,
    input [31:0] seg_data,
    output reg [2:0] cnt_sel,
    output reg[7:0] seg
);

    parameter CLK_FREQ = 50_000_000;
    parameter DIV_FREQ = 1000;
    parameter Mcnt = CLK_FREQ / DIV_FREQ - 1;

    reg [29:0] cnt_div;
    reg [3:0] data_temp;
    
    always @(posedge clk or negedge reset_n)
        if (!reset_n)
            cnt_div <= 0;
        else if (cnt_div == Mcnt)
            cnt_div <= 0;
        else
            cnt_div <= cnt_div + 1;
            
    always @(posedge clk or negedge reset_n)
        if (!reset_n)
            cnt_sel <= 0;
        else if (cnt_div == Mcnt)
            cnt_sel <= cnt_sel + 1;            
    
    always @(*)
        case(cnt_sel)
                0:data_temp = seg_data[3:0];  //第一位
                1:data_temp = seg_data[7:4];
                2:data_temp = seg_data[11:8];
                3:data_temp = seg_data[15:12];
                4:data_temp = seg_data[19:16];
                5:data_temp = seg_data[23:20];
                6:data_temp = seg_data[27:24];
                7:data_temp = seg_data[31:28];
        endcase


    always @(posedge clk)
        case(data_temp)
                0:seg <= 8'b1100_0000;
                1:seg <= 8'b1111_1001;
                2:seg <= 8'b1010_0100;
                3:seg <= 8'b1011_0000;
                4:seg <= 8'b1001_1001;
                5:seg <= 8'b1001_0010;
                6:seg <= 8'b1000_0010;
                7:seg <= 8'b1111_1000;
                8:seg <= 8'b1000_0000;
                9:seg <= 8'b1001_0000;
                4'ha:seg <= 8'b1000_1000;
                4'hb:seg <= 8'b1000_0011;
                4'hc:seg <= 8'b1100_0110;
                4'hd:seg <= 8'b1010_0001;
                4'he:seg <= 8'b1000_0110;
                4'hf:seg <= 8'b1000_1110;
        endcase

endmodule
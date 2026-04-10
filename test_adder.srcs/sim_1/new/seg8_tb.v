`timescale 1ns/1ps

module seg8_tb();
    reg clk;
    reg reset_n;
    reg [31:0] seg_data;
    wire [7:0] sel;
    wire [7:0] seg;
    
    seg8 u1(.clk(clk),.reset_n(reset_n),.seg_data(seg_data),.sel(sel),.seg(seg));
    
    initial clk = 1;
    always#10 clk = ~clk;
    
    initial begin
        reset_n = 0;
        seg_data = 32'h1234abcd;
        #201;
        reset_n = 1;
        #20_000_000;
        seg_data = 32'h87654321;
        #20_000_000;
        $stop;
    end
        
endmodule
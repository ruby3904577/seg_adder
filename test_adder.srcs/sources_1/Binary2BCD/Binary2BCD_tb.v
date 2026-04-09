`timescale 1ns/1ps

module Binary2BCD_tb;
    reg clk = 1'b1;
    always #5 clk = ~clk;
    
    reg [7:0] indata = 10'd0;
    wire [11:0] outdata;
    
    Binary2BCD u1(.indata(indata), .outdata(outdata));
    
    initial begin
        $monitor("Time=%0t Input=%d Output=%h", $time, indata, outdata);
        
        #10 indata = 10'd23;
        #10 indata = 10'd68;
        #10 indata = 10'd134;
        #10 indata = 10'd255;
        #10 $finish;
    end
endmodule

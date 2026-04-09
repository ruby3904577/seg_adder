`timescale 1ns/1ps

module bin2bcd_tb;
    reg clk = 1'b1;
    always #10 clk = ~clk;
    
    reg [9:0] indata = 10'd0;
    wire [15:0] outdata;
    
    bin2bcd u1(.indata(indata), .outdata(outdata));
    
    initial begin
        $monitor("Time=%0t Input=%d Output=%h", $time, indata, outdata);
        
        #20 indata = 10'd23;
        #20 indata = 10'd68;
        #20 indata = 10'd134;
        #20 indata = 10'd255;
        #20 $finish;
    end
endmodule

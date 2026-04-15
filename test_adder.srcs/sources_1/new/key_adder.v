`timescale 1ns / 1ps

module key_adder(
    input clk,
    input reset_n,
    input [6:0] a,b,
    input adder_en,
    output [11:0] q
    );
    wire [6:0] sum;
    reg [7:0] q_temp;
    
    //full_adder1 f0(a[0],b[0],0,sum[0],cin1);
    //full_adder1 f1(a[1],b[1],cin1,sum[1],cin2);
    //full_adder1 f2(a[2],b[2],cin2,sum[2],cin3);
    //full_adder1 f3(a[3],b[3],cin3,sum[3],cin4);
    //full_adder1 f4(a[4],b[4],cin4,sum[4],cin5);
    //full_adder1 f5(a[5],b[5],cin5,sum[5],cin6);
    //full_adder1 f6(a[6],b[6],cin6,sum[6],cout);
    
    //assign q_temp = {cout,sum};
    
    always @(posedge clk or negedge reset_n)
        if(!reset_n)
            q_temp <= 0;
        else if(adder_en)
            q_temp <= a + b;
        else
            q_temp <= q_temp;
            
    bin2bcd u1(.indata(q_temp),.outdata(q));
    
endmodule

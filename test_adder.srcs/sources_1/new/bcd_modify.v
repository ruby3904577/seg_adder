module bcd_modify(
    input [25:0] indata,
    output [25:0] outdata
    );
    wire [15:0] bcdin;
    wire [15:0] bcdout;
    assign bcdin = indata[25:10];
    bcd_single_modify b3_0(.bin(bcdin[3:0]),.bcd_out(bcdout[3:0]));
    bcd_single_modify b7_4(.bin(bcdin[7:4]),.bcd_out(bcdout[7:4]));
    bcd_single_modify b11_8(.bin(bcdin[11:8]),.bcd_out(bcdout[11:8]));
    bcd_single_modify b15_12(.bin(bcdin[15:12]),.bcd_out(bcdout[15:12]));
       
    assign outdata[25:10] = bcdout;
    assign outdata[9:0] = indata[9:0];
         
endmodule
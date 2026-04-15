module bcd_modify(
    input [19:0] indata,
    output [19:0] outdata
    );
    wire [11:0] bcdin;
    wire [11:0] bcdout;
    assign bcdin = indata[19:8];
    bcd_single_modify b3_0(.bin(bcdin[3:0]),.bcd_out(bcdout[3:0]));
    bcd_single_modify b7_4(.bin(bcdin[7:4]),.bcd_out(bcdout[7:4]));
    bcd_single_modify b11_8(.bin(bcdin[11:8]),.bcd_out(bcdout[11:8]));
    //bcd_single_modify b15_12(.bin(bcdin[15:12]),.bcd_out(bcdout[15:12]));
       
    assign outdata[19:8] = bcdout;
    assign outdata[7:0] = indata[7:0];
         
endmodule
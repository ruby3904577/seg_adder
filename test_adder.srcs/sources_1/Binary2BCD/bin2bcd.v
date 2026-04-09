module bin2bcd(
    input [9:0] indata,
    output [15:0] outdata
    );
    wire [25:0] shiftreg [10:0];
    assign shiftreg[10] = {16'b0,indata};
    bcd_modify b10(.indata(shiftreg[10] << 1),.outdata(shiftreg[9])); //二进制数第十位左移
    bcd_modify b9(.indata(shiftreg[9] << 1),.outdata(shiftreg[8]));
    bcd_modify b8(.indata(shiftreg[8] << 1),.outdata(shiftreg[7]));
    bcd_modify b7(.indata(shiftreg[7] << 1),.outdata(shiftreg[6]));
    bcd_modify b6(.indata(shiftreg[6] << 1),.outdata(shiftreg[5]));
    bcd_modify b5(.indata(shiftreg[5] << 1),.outdata(shiftreg[4]));
    bcd_modify b4(.indata(shiftreg[4] << 1),.outdata(shiftreg[3]));
    bcd_modify b3(.indata(shiftreg[3] << 1),.outdata(shiftreg[2]));
    bcd_modify b2(.indata(shiftreg[2] << 1),.outdata(shiftreg[1]));

    assign shiftreg[0] = shiftreg[1] << 1;
    assign outdata = shiftreg[0][25:10];
    
endmodule
module Binary2BCD(
    input [7:0] indata, //[7:0]
    output reg [12:0] outdata
    );
    reg [11:0] shiftreg;
    integer i;

    always @(*)begin
        shiftreg = 0;
        for(i = 0;i <= 7;i = i + 1)begin

            if (shiftreg[3:0] > 4'h4) 
                shiftreg[3:0] = shiftreg[3:0] + 2'd3;
            else
                shiftreg[3:0] = shiftreg[3:0];
            if (shiftreg[7:4] > 4'h4) 
                shiftreg[7:4] = shiftreg[7:4] + 2'd3;
            else
                shiftreg[7:4] = shiftreg[7:4];
            if (shiftreg[11:8] > 4'h4) 
                shiftreg[11:8] = shiftreg[11:8] + 2'd3;
            else
                shiftreg[11:8] = shiftreg[11:8];
                
            shiftreg = shiftreg << 1;
            shiftreg[0] = indata[7 -i];
        end
        outdata = shiftreg;
    end
     
endmodule

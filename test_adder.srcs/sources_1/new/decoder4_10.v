module decoder4_10(
    input wire [3:0] sin,
    output reg [8:0] sout
    );

    always@(*)begin
        case(sin)
            4'b0000:sout = 9'b0_0000_0000; //0
            4'b0001:sout = 9'b0_0000_0001; //1
            4'b0010:sout = 9'b0_0000_0010; //2
            4'b0011:sout = 9'b0_0000_0100; //3
            4'b0100:sout = 9'b0_0000_1000; //4
            4'b0101:sout = 9'b0_0001_0000; //5
            4'b0110:sout = 9'b0_0010_0000; //6
            4'b0111:sout = 9'b0_0100_0000; //7
            4'b1000:sout = 9'b0_1000_0000; //8
            4'b1001:sout = 9'b1_0000_0000; //9
            default:sout = 9'bZ;
        endcase
    end
endmodule

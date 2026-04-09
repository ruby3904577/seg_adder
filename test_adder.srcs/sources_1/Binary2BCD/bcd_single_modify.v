module bcd_single_modify(
    input [3:0] bin,
    output reg[3:0] bcd_out
    );
    always @(*)begin
    if (bin > 3'd4)
        bcd_out = bin + 2'd3;
    else
        bcd_out = bin;
    end
    
endmodule
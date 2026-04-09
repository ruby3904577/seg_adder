module full_adder1(
    input a,
    input b,
    input cin,
    output reg cout,sum
    );
    
    always @* begin
        {cout,sum} = a + b + cin;
    end
    
endmodule
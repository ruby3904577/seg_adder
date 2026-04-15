module bcd2bin     					
( 
	input		[7:0]	indata,	
	output wire	[6:0]	outdata   
	); 	

	wire [3:0] in_ten,in_one;

	assign in_ten = indata[7:4];
	assign in_one = indata[3:0];
	assign outdata = (in_ten << 3) + (in_ten << 1) + in_one;

endmodule

module crc8_byte(
		input wire clk,
		input wire rst_n,
		input wire [7:0] in,
		input wire enable,
		input wire clr,

		output wire[7:0] out,
		output wire complete
	);

	input shift;
	input iterator;

	crc8 calculate(
				.rst_n(rst_n), 
				.clk(clk), 
				.shift(shift), 
				.clr(clr), 
				.in(iterator), 
				.ouput(out)) 

	for(i = 0; i < 8; i=i+1) begin
		
	end
	
	reg [2:0] counter; 

	always @(posedge clk)
		if(!rst_in)
module crc8_byte(
		input wire clk,
		input wire rst_n,
		input wire [7:0] in,
		input wire enable,
		input wire clr,

		output wire[7:0] out,
		output wire complete
	);




	reg data[7:0]
	assign iterator = data[7];

	crc8 calculate(
				.rst_n(rst_n), 
				.clk(clk), 
				.shift(shift), 
				.clr(clr), 
				.in(iterator), 
				.ouput(out)
				) 



	always @(posedge clk)
		begin
		if(enable)
			shift <= 1;
			data <= {data[6:0], reg[7]};
		end

	



endmodule
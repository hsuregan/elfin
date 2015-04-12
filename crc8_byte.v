module crc8_byte(
		input wire clk,
		input wire rst_n,
		input wire [7:0] in,
		input wire enable,
		input wire clr,

		output wire[7:0] out,
		output wire complete
	);


	reg data[7:0]; //store data into register
	input cur_bit; //points to most significant bit in the input byte
	assign cur_bit = data[7];

	always @(rst_n) //rst_n to initialize the temp data register (inital begin doesn't synthesize)
		begin
			data = in;
		end

	crc8 calculate(
				.rst_n(rst_n), 
				.clk(clk), 
				.shift(shift), 
				.clr(clr), 
				.in(cur_bit), 
				.ouput(out)
				) 

	always @(posedge clk)
		begin
		if(enable)
			shift <= 1;
			data <= {data[6:0], reg[7]};
		end

	



endmodule
module crc8_byte(
		input wire clk,
		input wire rst_n,
		input wire [7:0] in,
		input wire enable,
		input wire clr,

		output wire[7:0] out,
		output wire complete
	);
	

	reg[2:0] counter; //at 3'b111; turn complete one
	wire cur_bit; //points to most significant bit in the input byte
	assign cur_bit = in[counter];

	crc8 calculate(
				.rst_n(rst_n), 
				.clk(clk), 
				.shift(enable), 
				.clr(clr), 
				.in(cur_bit), 
				.ouput(out) //output of my module is the crc 
				);

	//counter
	always @(posedge clk or negedge rst)
	begin
		if((rst_n && (counter < 7))	//processing bits
			counter = counter + 1;
		else if(!rst) 	//one byte processed:
			counter = 0;
	end

	//complete
	always @(posedge clk)
	begin
		if(counter == 7)
			complete = 0;
	end



endmodule
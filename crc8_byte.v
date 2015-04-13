module crc8_byte(
		input wire clk,
		input wire rst_n,
		input wire [7:0] in,
		input wire enable,
		input wire clr,

		output wire[7:0] out,
		output wire complete
	);


	reg data[7:0]; //store data into shift register
	reg counter[2:0]; //at 3'b111; turn complete one
	input cur_bit; //points to most significant bit in the input byte
	assign cur_bit = data[7];

	always @(rst_n) //rst_n to initialize the temp data reg; also resets temp register whenever rst_n is high
		begin
			data = in;
			counter <= 0;
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
			if(enable && (counter < 0b'111))
			begin
				counter <= counter + 1;
				shift <= 1;
				data <= {data[6:0], reg[7]};
			end else if(counter == 0b'111)
			begin
				counter = 0b'0;
			end else //enable is off
			
			end
		end

	



endmodule
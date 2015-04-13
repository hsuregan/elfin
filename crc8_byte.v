module crc8_byte(
		input wire clk,
		input wire rst_n,
		input wire [7:0] in,
		input wire enable,
		input wire clr,

		output wire[7:0] out,
		output wire complete
	);
	
	//wire[7:0] intodata;
	//assign intodata = in;

	reg[7:0] data; //store 'in' into this shift reg 'data'
	reg[2:0] counter; //at 3'b111; turn complete one
	wire cur_bit; //points to most significant bit in the input byte
	assign cur_bit = data[7];
	reg shift;
	reg process;

	assign complete = process;

	crc8 calculate(
				.rst_n(rst_n), 
				.clk(clk), 
				.shift(shift), 
				.clr(clr), 
				.in(cur_bit), 
				.ouput(out) //output of my module is the crc 
				);

	always @(posedge clr) //asynchronous clr
	begin
		data <= in;
		counter <= 0;
		shift = 0;
	end

	always @(negedge enable)
	begin
		shift <= 0;
	end

	always @(posedge enable)
	begin
		shift <= 1;
	end

	always @(posedge clk) //or (negedge rst_n) and enable and (!clr))
			if((rst_n) && (counter < 7)) //case in which counter is below 7
			begin
				shift <= 1;
				counter <= counter + 1;
				data <= {data[6:0], data[7]};
			end else if(counter == 7) //case in which a byte of data has been processed
			begin
				shift <= 0; //do not shift into pat's module
				counter <= 0; //set counter back to zero
				process <= 1; //crc for byte complete
			end else if(!rst_n) //case in which rst, set counter to 0, INSTANTIATES
			begin
				data <= in;
				counter <= 0;
				shift <= 0;
			end

		


endmodule
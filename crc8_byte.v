module crc8_byte(
		input wire clk,
		input wire rst_n,
		input wire [7:0] in,
		input wire enable,
		input wire clr,

		output wire[7:0] out,
		output wire complete
	);
	

	reg[3:0] counter; //at 3'b111; turn complete on
	reg byte_processed;
	reg crc8enable; //!ASSUME: enable is a one clock pulse

	assign complete = byte_processed;
	wire cur_bit; //points to most significant bit in the input byte
	assign cur_bit = in[counter];



	crc8 calculate(
				.rst_n(rst_n), 
				.clk(clk), 
				.shift(enable), //switch out enable w crc8enable 
				.clr(clr), 
				.in(cur_bit), 
				.crc(out) //output of my module is the crc 
				);

	//enable logic
	//bc enable is one clock pulse, sample enable and store into crc8enable
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n) crc8enable <= 0;
		else if(enable) crc8enable <= 1;
		else if(counter == 8) crc8enable <= 0; // counter = 8 ? IDLE : ACTIVE

	end
	

	//counter
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n) counter <= 8;
		else if (counter < 8) counter <= counter + 1;
		else if (enable) counter <= 0; //IDLE -> ACTIVE

						/*if(rst_n && (counter < 8))	//processing bits
							counter <= counter + 1;
						else if(!rst_n) 	//one byte processed:
							counter <= 0;*/
	end

	//complete
	always @(posedge clk)
	begin
		if (!rst_n)
			byte_processed <= 0;
		else if(counter == 7)
			byte_processed <= 1;
		else
			byte_processed <= 0;
	end



endmodule

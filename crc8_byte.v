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
	wire crc_enable;  //!ASSUME: enable is a one clock pulse
	assign crc_enable = counter < 8;

	//CAN I DO EITHER OF THESE (LOGIC WISE?)
	//assign complete = (out == in);
	//assign complete = (counter == 7)&rst_n;

	assign complete = byte_processed;
	wire cur_bit; //the bit that is fed into crc8
	assign cur_bit = in[7-counter];

	crc8 calculate(
				.rst_n(rst_n), 
				.clk(clk), 
				.shift(crc_enable), //switch out enable w crc8enable 
				.clr(clr), 
				.in(cur_bit), 
				.crc(out) //output of my module is the crc 
			);

	//counter
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n) counter <= 8;
		else if (enable) counter <= 0; //enable takes IDLE state to ACTIVE state
		else if (counter < 8) counter <= counter + 1;
	end

	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n) byte_processed <= 0;
		else if(counter == 7) byte_processed <= 1;
		else byte_processed <= 0;
	end



endmodule

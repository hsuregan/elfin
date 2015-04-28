module crc8_byte_tb();

reg clk;
reg rst_n;
reg [7:0] in;
reg enable;
reg clr;

wire [7:0] out;
wire complete;

crc8_byte UUT(.clk(clk), .rst_n(rst_n), .in(in), .enable(enable), .clr(clr), .out(out), .complete(complete));

	
always begin
		#5 clk = ~clk;
end

initial begin
	clk <= 0;
	rst_n <= 1;
	enable <= 1;
	clr <= 0;
	#5 rst_n <= 0;
	#6 rst_n <= 1;
	#10	in = 0'b10101110;
	//#200 rst_n <= 0;
	//#210 rst_n <= 1;

end

endmodule
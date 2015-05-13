module crc8_byte_tb();

reg clk;
reg rst_n;
reg [7:0] in;
reg enable;
reg clr;
reg [8:0] i;

wire [7:0] out;
wire complete;
reg [7:0] arr_index;

crc8_byte UUT(.clk(clk), .rst_n(rst_n), .in(in), .enable(enable), .clr(clr), .out(out), .complete(complete));

	
always begin
		#1 clk = ~clk;
end

initial begin
	clk <= 0;
	rst_n <= 1;
	clr <= 0;
	#5 rst_n <= 0;
	#5 rst_n <= 1;
	#5 in = 0'b00000000;
	#5 enable <= 1;
	#5 enable <= 0;
	//#5 in = 0'b00000000;
	//#500 enable <= 1;
	//#5 enable <= 0;
	#1 clr <= 1;
	#1 clr <= 0; 

	for(i = 0; i < 256; i = i+1 ) begin
		$display("%d",i);
		#1 in = i;
		#1 enable <= 1;
		#2 enable <= 0;
		#20 arr_index <=  in ^ out;

	end
	//#200 rst_n <= 0;
	//#210 rst_n <= 1;

end

endmodule
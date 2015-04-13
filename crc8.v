module crc8(
   input wire rst_n,
   input wire clk,
   input wire shift,
   input wire clr,
   input wire in,
   output reg[7:0] crc
   );

//if reset is low, input 0
//if clear, input 0
//if shift, then: new reg [7:0] = reg [6:3] ; xor manipulations for the rest

 
   always @(posedge clk or negedge rst_n)
     if (!rst_n) crc <= 0;
     else if (clr) crc <= 0;
     else if (shift) crc <= {crc[6:3],crc[7]^crc[2],crc[7]^crc[1],crc[7]^in};
 
 
 
 endmodule

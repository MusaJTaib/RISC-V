module IMEM(PCSel,ALURes,PCounter,CLK,IMout,PCad);
reg [7:0]adder;
input[31:0]ALURes,PCounter;
input CLK,PCSel;
output [7:0]PCad;
output [31:0]IMout;
always@(posedge CLK)//act as a MUX to select whether pc+1 or ALURes
begin
if(PCSel)
adder <= ALURes[7:0]+1'b1;
else
adder  <= PCounter[7:0]+1'b1;
end
assign PCad = adder;
MEMin m1(adder,CLK,IMout);
endmodule


module MEMin
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output [(DATA_WIDTH-1):0] q
);
   reg [(DATA_WIDTH-1):0] q1;
	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_rom_init.txt.  Without this file,
	// this design will not compile.

	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file, or see the "Using $readmemb and $readmemh"
	// template later in this section.

	initial
	begin
		$readmemh("IMEM.txt", rom);
	end

	always @ (posedge clk)
	begin
		q1 <= rom[addr];
	end
assign q= q1;
endmodule

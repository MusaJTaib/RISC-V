//main
module MAIN



endmodule



// Quartus II Verilog Template
// Single Port ROM

module single_port_rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q
);

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
		$readmemb("single_port_rom_init.mif", rom);
	end

	always @ (posedge clk)
	begin
		q <= rom[addr];
	end

endmodule



module ALU(ALUSel,CLK,I1,I2,I3);
input [3:0]ALUSel;
input CLK;
input [31:0]I1,I2;//I1 IS A AND I2 IS B
output[31:0]I2;
wire [63:0]C1;
always@(posedge CLK)
begin
case(ALUSel)
4'b0001:
begin//add
I3 = I1+I2;end
4'b0010:
begin//and
I3 = I1&I2;
end
4'b0011:
begin//or
I3 = I1|I2;
end
4'b0100:
begin//xor
I3 = I2^I1;
end
4'b0101:
begin//srl
I3 = I1>>I2[4:0];
end
4'b0110:
begin//sra
I3 = I1>>>I2[4:0];
end
4'b0111:
begin//sll
I3 = I1<<I2[4:0];
end
4'b1000:
begin//slt
if(I1<I2)
I3=1;
else
I3=0;
end
4'b1001:
begin//div
I3=I1/I2;
end
4'b1010:
begin//rem
I3= I1%I2;
end
4'b1011:
begin//mult
I3 = I2*I1;
end
4'b1100:
begin//multh
C1 = I2*I1;
I3 = C1[63:32]
end
4'b1101:
begin//sub
I3 = I1-I2;
end
4'b1110:
begin//bsel
I3 = I2;
end

end




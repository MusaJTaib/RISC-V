module REG 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=5)
(
	input [(ADDR_WIDTH-1):0] addr,
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr1,addr2,
	input we, clk,
	output [(DATA_WIDTH-1):0] q1,q2
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg1;
   reg [ADDR_WIDTH-1:0] addr_reg2;
	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;

		addr_reg1 <= addr1;
		addr_reg2 <= addr2;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q1 = ram[addr_reg1];
	assign q2 = ram[addr_reg2];
endmodule



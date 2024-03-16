module ALU(ALUSel,CLK,I1,I2,I3);
input [3:0]ALUSel;
input CLK;
input [31:0]I1,I2;//I1 IS A AND I2 IS B
//to remove assign error in sltu
reg [31:0]I1n,I2n;
output reg[31:0]I3;
reg [63:0]C1;
always@(posedge CLK)
begin
case(ALUSel)
4'b0001:
begin//add
I3 = I1+I2;
end
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
I3 = C1[63:32];
end
4'b1101:
begin//sub
I3 = I1-I2;
end
4'b1110:
begin//bsel
I3 = I2;
end
4'b1111:
begin//sltu
I1n = $unsigned(I1);
I2n = $unsigned(I2);
if(I1n<I2n)
I3=1;
else
I3=0;
end
endcase
end
endmodule
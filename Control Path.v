module Control(In1,CLK,BrEq,BrLT,PCSel,ImmSel,BrUn,ASel,BSel,ALUSel,MemRW,RegWEn,WBSel,BRSel);
input CLK,BrEq,BrLT;
output reg PCSel,BrUn,ASel,BSel,MemRW,RegWEn,BRSel;
output reg [2:0]ImmSel;
output reg [3:0]ALUSel;
output reg [1:0]WBSel;
reg [6:0] funct7,opcode;//remember inside always block we always use reg but outside the always we use wire
reg [2:0] funct3;
parameter R=7'b0110011 ,S=7'b0100011 ,Il = 7'b0000011 ,IS = 7'b0010011,Ij =7'b1100111 ,SB=7'b1100011 ;
input [31:0] In1;
always@(posedge CLK)
begin
funct3 = In1[14:12];
funct7 = In1[31:25];
opcode = In1[6:0];
case(opcode)
R:
begin 
PCSel = 0;
BrUn = 0;
ASel = 1;
BSel = 1;
MemRW = 0;
RegWEn = 1;
WBSel = 2'b01;
ImmSel = 3'bxxx;
case(funct3)
3'b000:
begin
if(funct7 == 0000000)
ALUSel = 4'b0001;//add
else
ALUSel = 4'b1101;//sub
end
3'b001:ALUSel = 4'b0111;//sll
3'b010:ALUSel = 4'b1000;//slt
3'b011:ALUSel = 4'b1111;//sltu
3'b100:ALUSel = 4'b0100;//xor
3'b101://srl#sra
begin
if(funct7 == 0000000)
ALUSel = 4'b0101;//srl
else
ALUSel = 4'b0110;//sra
end
3'b110:ALUSel = 4'b0011;//or
3'b111:ALUSel = 4'b0010;//and
endcase
end
S:
begin
PCSel = 0;
BrUn = 0;
ASel = 1;
BSel = 0;
MemRW = 1;
RegWEn =0 ;
WBSel = 2'bxx;
ALUSel = 4'b0001;
ImmSel = 3'b010;
end

Il://only contains load word
begin
PCSel = 0;
BrUn = 1'bx;
ASel = 1;
BSel = 0;
MemRW = 0;
RegWEn = 1;
WBSel = 2'b00;
ALUSel = 4'b0001;
ImmSel = 3'b000;
end

IS:
begin
PCSel =0 ;
BrUn = 1'bx;
ASel = 1;
BSel = 0;
MemRW = 1'bx;
RegWEn = 1;
WBSel = 2'b01;
ImmSel = 3'b000;
case(funct3)
3'b000:ALUSel = 4'b0001;//addi
3'b001:ALUSel = 4'b0111;//slli
3'b010:ALUSel = 4'b1000;//slti
3'b011:ALUSel = 4'b1111;//sltiu
3'b100:ALUSel = 4'b0100;//xori
3'b101:
begin
if(funct7 == 0000000)
begin
ALUSel = 4'b0101;//srli
end
else
ALUSel = 4'b0110;//srai
end
3'b110:ALUSel = 4'b0011;//ori
3'b111:ALUSel = 4'b0010;//andi
endcase
end

Ij:
begin
PCSel = 1;
BrUn = 1'bx;
ASel = 0;
BSel = 0;
MemRW = 1'bx;
RegWEn = 1;
WBSel = 2'b10;
ALUSel = 4'b0001;
ImmSel = 3'b000;
end


SB:
begin
PCSel = 0;
ASel = 0;
BSel = 0;
MemRW = 1'bx;
RegWEn = 1'bx;
WBSel = 2'bx;
ALUSel = 4'bx;
ImmSel = 3'b101;
BrUn = funct3[1];
case(funct3)//Make this work in order to Work for Branch .SO change PCSel and BrUn 
3'b000://beq
BRSel = BrEq;

3'b001://bne
BRSel = ~BrEq;

3'b100://blt
BRSel = BrLT;

3'b101://bge
BRSel =~BrLT;

3'b110://bltu
BRSel=BrLT;

3'b111://bgeu
BRSel =~BrLT;


endcase
end
endcase
end

endmodule

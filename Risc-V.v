module RiscV(CLK,RESET,ALUres3);
output[31:0]ALUres3;
wire [31:0]ALUres;//assign this reg type to a wire type and use the dummies
wire [31:0]IF1,IF2,ID1,ID2,retur1n,IMM1,IMM2 ,IMM3,DM1,DM2,MUX2,PCounter,PCounter2,PCounter3,PCounter4,PCounter5;
wire [2:0]ImmSel,ImmSel2,ImmSel3,ImmSel4,ImmSel5;
wire BrUn,ASel,BSel,MemRW,RegWEn,BRSel,BRSel2,BRSel3,BRSel4,BRSel5;
wire BrUn2,ASel2,BSel2,MemRW2,RegWEn2;
wire BrUn3,ASel3,BSel3,MemRW3,RegWEn3;
wire BrUn4,ASel4,BSel4,MemRW4,RegWEn4;
wire BrUn5,ASel5,BSel5,MemRW5,RegWEn5;
reg [31:0]Mux1,Mux2,Mux3;
wire[31:0]Mux3We,Mux3bWe,Mux3c;
wire [7:0]PCad;
wire [3:0]ALUSel,ALUSel2,ALUSel3,ALUSel4,ALUSel5;
wire [1:0]WBSel2,WBSel3,WBSel4,WBSel5;
wire PCSel,PCSel2,PCSel3,PCSel4,PCSel5;
input CLK,RESET;
wire [4:0]rs1a,rs2a;

//IF
IMEM I1(PCSel5,Mux3c,PCounter4,CLK,IF1,PCad);//for ALUres check correct names 0 means +4 1 means alures
wire [4:0]rs1b,rs2b,rb2;
assign rs2a = IF1[24:20];
assign rs1a = IF1[19:15];
assign rb2 = IF1[11:7];
assign PCounter = {{24{1'b0}},{PCad[7:0]}};
wire [4:0]rb3;
//This was the previous location of calling control path
FLipFD ff1(rs2a,rs2b,CLK);
defparam ff1.Width=5;
FLipFD ff2(rs1a,rs1b,CLK);
defparam ff2.Width=5;
FLipFD ff3(IF1,IF2,CLK);
defparam ff3.Width=32;
FLipFD ffn1(PCounter,PCounter2,CLK);
defparam ffn1.Width=32;
FLipFD ffn221(rb2,rb3,CLK);
defparam ff1.Width=5;
//controlpath Dflipflop



//ID

FLipFD ff4(ReD1a,ReD1b,CLK);
defparam ff4.Width=32;
FLipFD ff5(ReD2a,ReD2b,CLK);
defparam ff5.Width=32;
FLipFD ff6(retur1n,IMM1,CLK);
defparam ff6.Width=32;
FLipFD ffn2(PCounter2,PCounter3,CLK);
defparam ffn2.Width=32;
FLipFD ffn222(rb3,rb4,CLK);
defparam ff1.Width=5;
//CONtrolpath
FLipFD cff11(WBSel2,WBSel3,CLK);
defparam cff11.Width=2;
FLipFD cff12(ALUSel2,ALUSel3,CLK);
defparam cff12.Width=4;
FLipFD cff13(ImmSel2,ImmSel3,CLK);
defparam cff13.Width=3;
FLipFD cff14(PCSel2,PCSel3,CLK);
defparam cff14.Width=1;
FLipFD cff15(BrUn2,BrUn3,CLK);
defparam cff15.Width=1;
FLipFD cff16(ASel2,ASel3,CLK);
defparam cff16.Width=1;
FLipFD cff17(BSel2,BSel3,CLK);
defparam cff17.Width=1;
FLipFD cff18(MemRW2,MemRW3,CLK);
defparam cff18.Width=1;
FLipFD cff19(RegWEn2,RegWEn3,CLK);
defparam cff19.Width=1;
FLipFD cffnt1(BRSel2,BRSel3,CLK);
defparam cffnt1.Width=1;
//EX 
//remember to make that shift by 1 byte thing
always@(*)//
begin
if(BRSel3)//for SB case check what value of PC SEl needs to be placed here
Mux3 = IMM1;
else
Mux3 = ALUres;
end
assign Mux3We=Mux3;

always@(*)
begin
if(BSel3)
Mux1 = ReD2b;
else
Mux1 = IMM1;
end

always@(*)
begin
if(ASel3)
Mux2 = ReD1b;
else
Mux2 = PCounter3;
end

ALU A1(ALUSel,CLK,Mux2,Mux1,ALUres);//note that mux 1 will decide what will go inside ALU whether imm or data
wire [4:0]rb5;
wire [31:0]ALUres2;//assign this reg type to a wire type and use the dummies
//remember to cater for UJ instructionset
FLipFD ff7(ALUres,ALUres2,CLK);
defparam ff7.Width=32;
FLipFD ff8(ReD2b,ReD2c,CLK);
defparam ff8.Width=32;
FLipFD ff9(IMM1,IMM2,CLK);
defparam ff9.Width=32;
FLipFD ffn3(PCounter3,PCounter4,CLK);
defparam ffn3.Width=32;
FLipFD ffn3aa(Mux3We,Mux3bWe,CLK);
defparam ffn3aa.Width=32;
FLipFD ffn223(rb4,rb5,CLK);
defparam ff1.Width=5;
//COntrolpath
FLipFD cffnt2(BRSel3,BRSel4,CLK);
defparam cffnt2.Width=1;
FLipFD cff21(WBSel3,WBSel4,CLK);
defparam cff21.Width=2;
FLipFD cff22(ALUSel3,ALUSel4,CLK);
defparam cff22.Width=4;
FLipFD cff23(ImmSel3,ImmSel4,CLK);
defparam cff23.Width=3;
FLipFD cff24(PCSel3,PCSel4,CLK);
defparam cff24.Width=1;
FLipFD cff25(BrUn3,BrUn4,CLK);
defparam cff25.Width=1;
FLipFD cff26(ASel3,ASel4,CLK);
defparam cff26.Width=1;
FLipFD cff27(BSel3,BSel4,CLK);
defparam cff27.Width=1;
FLipFD cff28(MemRW3,MemRW4,CLK);
defparam cff28.Width=1;
FLipFD cff29(RegWEn3,RegWEn4,CLK);
defparam cff29.Width=1;


//MEM
single_port_ram SP1(ReD2c,ALUres2,MemRW4,CLK,DM1);
wire [4:0]rb6;
FLipFD ff10 (DM1,DM2,CLK);
defparam ff10.Width=32;
FLipFD ff11(ReD2c,ReD2d,CLK);
defparam ff11.Width=32;
FLipFD ff12(ALUres2,ALUres3,CLK);
defparam ff12.Width=32;
FLipFD ff13(IMM2,IMM3,CLK);
defparam ff13.Width=32;
FLipFD ffn4(PCounter4,PCounter5,CLK);
defparam ffn4.Width=32;
FLipFD ffn3ab(Mux3bWe,Mux3c,CLK);
defparam ffn3ab.Width=32;
FLipFD ffn224(rb5,rb6,CLK);
defparam ff1.Width=5;
//controlpath
FLipFD cffnt3(BRSel4,BRSel5,CLK);
defparam cffnt3.Width=1;
FLipFD cff31(WBSel4,WBSel5,CLK);
defparam cff31.Width=2;
FLipFD cff32(ALUSel4,ALUSel5,CLK);
defparam cff32.Width=4;
FLipFD cff33(ImmSel4,ImmSel5,CLK);
defparam cff33.Width=3;
FLipFD cff34(PCSel4,PCSel5,CLK);
defparam cff34.Width=1;
FLipFD cff35(BrUn4,BrUn5,CLK);
defparam cff35.Width=1;
FLipFD cff36(ASel4,ASel5,CLK);
defparam cff36.Width=1;
FLipFD cff37(BSel4,BSel5,CLK);
defparam cff37.Width=1;
FLipFD cff38(MemRW4,MemRW5,CLK);
defparam cff38.Width=1;
FLipFD cff39(RegWEn4,RegWEn5,CLK);
defparam cff39.Width=1;

//WB
reg[31:0]MUX2a;
always@(*)
begin
case(WBSel5)
00:MUX2a = DM2;
01:MUX2a = ALUres3;
default:MUX2a = PCounter5;
endcase
end




endmodule

//other modules
module FLipFD
#(parameter Width = 2)
(input [(Width-1):0]dataIN,
output [(Width-1):0]dataOUT,
input CLK);
reg [(Width-1):0]dataOUT2;
always @ (posedge CLK)
begin
	dataOUT2	<= dataIN;
end 
assign dataOUT = dataOUT2;
endmodule

module IMMEGEN(pc,ImmSel,Im1,retur1n);//IN1 is the input
input [2:0]ImmSel;
input [31:0]Im1;
output reg[31:0]retur1n;
reg [31:0]w8,w9,w10;
input [31:0]pc;

always@(*)
begin
case(ImmSel)
3'b000:
begin
retur1n = {{20{Im1[31]}},Im1[31:20]};//I
end
3'b010:
begin
retur1n = {{20{Im1[11]}},Im1[31:25],Im1[11:7]};//S
end
3'b100:
begin
retur1n = {{12{Im1[31]}},Im1[31:12]};//U
end
3'b101:
begin
w8 = {{13{Im1[20]}},Im1[10:1],Im1[11],Im1[19:12]};//SB
w9 = w8<<1;
w10 = pc - 4;
retur1n = w10 + w9;
end
default: retur1n = 32'bx;
endcase
end
endmodule

////////////////////////////////////////BranchModule
module BranC(dataA,dataB,BrUn,BrEq,BrLT);
input BrUn;
input [31:0]dataA,dataB;
reg [31:0]udataA,udataB;
output reg BrEq,BrLT;
always@(*)
begin
 udataA = $unsigned(dataA);
 udataB = $unsigned(dataB);
case(BrUn)
1://unsigned
begin
if(udataA == udataB)
BrEq = 1;
else
if(udataA < udataB)
BrLT = 1;
end

0://signed
begin
if(dataA == dataB)
BrEq = 1;
else
if(dataA < dataB)
BrLT = 1;
end
endcase
end
endmodule

endmodule
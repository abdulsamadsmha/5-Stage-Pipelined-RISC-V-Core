`timescale 1ns / 1ps
module control_unit(input [6:0]op,input [2:0] funct3,input funct7_5,output reg RegWriteD,
output reg[1:0]ResultSrcD,output reg MemWriteD,output reg JumpD,output reg BranchD,
output [2:0]ALUControlD,output reg ALUSrcD,output reg [1:0]ImmSrcD);
reg [1:0]ALUOp ;
wire op_5;
always@(*)begin
case(op)
7'b0110011:begin
RegWriteD = 1'b1;
ResultSrcD = 2'b00;
MemWriteD=1'b0;
JumpD=1'b0;
BranchD=1'b0;
ALUSrcD=1'b0;
ImmSrcD = 2'bxx;
ALUOp = 2'b10;
end
7'b0000011:begin
RegWriteD = 1'b1;
ResultSrcD = 2'b01;
MemWriteD=1'b0;
JumpD=1'b0;
BranchD=1'b0;
ALUSrcD=1'b1;
ImmSrcD = 2'b00;
ALUOp = 2'b00;
end
7'b0100011:begin
RegWriteD = 1'b0;
ResultSrcD = 2'bxx;
MemWriteD=1'b1;
JumpD=1'b0;
BranchD=1'b0;
ALUSrcD=1'b1;
ImmSrcD = 2'b01;
ALUOp = 2'b00;
end
7'b1100011:begin
RegWriteD = 1'b0;
ResultSrcD = 2'bxx;
MemWriteD=1'b0;
JumpD=1'b0;
BranchD=1'b1;
ALUSrcD=1'b0;
ImmSrcD = 2'b10;
ALUOp = 2'b01;
end
7'b0010011:begin
RegWriteD = 1'b1;
ResultSrcD = 2'b00;
MemWriteD=1'b0;
JumpD=1'b0;
BranchD=1'b0;
ALUSrcD=1'b1;
ImmSrcD = 2'b00;
ALUOp = 2'b10;
end
7'b1101111:begin
RegWriteD = 1'b1;
ResultSrcD = 2'b10;
MemWriteD=1'b0;
JumpD=1'b1;
BranchD=1'b0;
ALUSrcD=1'bx;
ImmSrcD = 2'b11;
ALUOp = 2'bxx;
end
default:begin
RegWriteD = 1'b0;
ResultSrcD = 2'b00;
MemWriteD=1'b0;
JumpD=1'b0;
BranchD=1'b0;
ALUSrcD=1'b0;
ImmSrcD = 2'b00;
ALUOp = 2'b00;
end
endcase
end
assign op_5 = op[5];
ALUDecoder f1(.funct3(funct3),.funct7_5(funct7_5),.op_5(op_5),.ALUOp(ALUOp),
.ALUControlD(ALUControlD)
    );

endmodule

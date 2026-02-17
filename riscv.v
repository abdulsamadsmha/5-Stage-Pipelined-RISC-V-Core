`timescale 1ns / 1ps
module riscv(input clk,input rst

    );
    wire StallF;
    wire PCSrcE;
    wire [31:0]PCF;
    wire [31:0]PCTargetE;
    wire [31:0]InstrF;   
    wire [31:0]PCPlus4F;
    pc_logic k1(.clk(clk),.StallF(StallF),.PCSrcE(PCSrcE),.PCF(PCF),.PCTargetE(PCTargetE),.rst(rst));    
    instruction_memory k17(.A(PCF),.RD(InstrF));
    assign PCPlus4F = PCF +4;
    wire BranchE;
    wire JumpE;
    wire ZeroE;
    assign PCSrcE = (BranchE & ZeroE)|JumpE;
    wire StallD;
    wire FlushD;
    wire [31:0]InstrD;
    wire [31:0]PCD;
    wire [31:0] PCPlus4D;
    IF_ID k2(.StallD(StallD),.FlushD(FlushD),.clk(clk),.PCF(PCF),.PCPlus4F(PCPlus4F),
.InstrF(InstrF),.InstrD(InstrD),
.PCD(PCD),.PCPlus4D(PCPlus4D),.rst(rst)
);
    wire [31:0] ResultW;
    wire [4:0] RdW;
    wire RegWriteW;
    wire [31:0]RD1;
    wire [31:0]RD2;
    Register_file k3( .A1(InstrD[19:15]),.A2(InstrD[24:20]),.clk(clk) , 
    .ResultW(ResultW) , .RdW(RdW),
 .RegWriteW(RegWriteW),.RD1(RD1),.RD2(RD2)
 );
 wire RegWriteD;
wire [1:0]ResultSrcD;wire MemWriteD;wire JumpD;wire BranchD;
wire [2:0]ALUControlD;wire ALUSrcD;wire [1:0]ImmSrcD;wire [4:0]Rs1D;wire [4:0]Rs2D;

wire [4:0] Rs1D, Rs2D;
assign Rs1D = InstrD[19:15];
assign Rs2D = InstrD[24:20];
     control_unit k4 (.op(InstrD[6:0]),.funct3(InstrD[14:12]),.funct7_5(InstrD[30]),
     .RegWriteD(RegWriteD),
.ResultSrcD(ResultSrcD),.MemWriteD(MemWriteD),.JumpD(JumpD),.BranchD(BranchD),
.ALUControlD(ALUControlD),.ALUSrcD(ALUSrcD),.ImmSrcD(ImmSrcD));
wire [31:0]ImmExtD;

Extend k5 (.ImmSrcD(ImmSrcD),.InstrD(InstrD[31:7]),.ImmExtD(ImmExtD));
wire FlushE;wire RegWriteE;wire [1:0]ResultSrcE;wire MemWriteE; 
wire [2:0]ALUControlE;wire ALUSrcE;wire[31:0] RD1E ;wire [31:0]RD2E ;wire [31:0]PCE ;wire [4:0]Rs1E ;
wire [4:0] Rs2E ;
wire [4:0] RdE ;wire [31:0] ImmExtE ; wire [31:0] PCPlus4E;  

ID_EX k6(.RegWriteD(RegWriteD),.ResultSrcD(ResultSrcD),.MemWriteD(MemWriteD),
.JumpD(JumpD),.BranchD(BranchD),
.ALUControlD(ALUControlD),.ALUSrcD(ALUSrcD),.RD1(RD1),.RD2(RD2),.PCD(PCD),
.Rs1D(InstrD[19:15]),.Rs2D(InstrD[24:20]),.RdD(InstrD[11:7]),.ImmExtD(ImmExtD),
.PCPlus4D(PCPlus4D),
.RegWriteE(RegWriteE),.ResultSrcE(ResultSrcE),.MemWriteE(MemWriteE),.JumpE(JumpE),
.BranchE(BranchE),
.ALUControlE(ALUControlE),.ALUSrcE(ALUSrcE),.RD1E(RD1E),
.RD2E(RD2E),.PCE(PCE),
.Rs1E(Rs1E),.Rs2E(Rs2E),.RdE(RdE),
.ImmExtE(ImmExtE),.PCPlus4E(PCPlus4E),.clk(clk),.FlushE(FlushE),.rst(rst)
    );
    wire [31:0]ALUResultM;wire [1:0]ForwardAE;wire [1:0]ForwardBE; wire [31:0] SrcAE;
wire [31:0] SrcBE;wire [31:0]WriteDataE; wire [31:0] ResultM;
  

forwarding_mux k7 (.RD1E(RD1E),.ResultW(ResultW),
.ALUResultM(ALUResultM) ,.ForwardAE(ForwardAE),.SrcAE(SrcAE),
.RD2E(RD2E),.ForwardBE(ForwardBE) ,.WriteDataE(WriteDataE) ,
.SrcBE(SrcBE) ,.ALUSrcE(ALUSrcE),
.ImmExtE(ImmExtE)
    );
    wire [31:0] ALUResultE;
    
    ALU k8 (.SrcAE(SrcAE),.SrcBE(SrcBE),.ALUControlE(ALUControlE),
.ALUResultE(ALUResultE)
,.ZeroE(ZeroE)
    );
    branch_target k9 (
    .PCE(PCE),
    .ImmExtE(ImmExtE),
    .PCTargetE(PCTargetE)
);
wire RegWriteM;
wire [1:0]ResultSrcM;
wire MemWriteM;
wire [31:0]WriteDataM;
wire [4:0]RdM;
wire [31:0]PCPlus4M;
EX_MEM k10 (
.RegWriteE(RegWriteE),
.ResultSrcE(ResultSrcE),
.MemWriteE(MemWriteE),
.ALUResultE(ALUResultE),
.WriteDataE(WriteDataE),
.RdE(RdE),
.PCPlus4E(PCPlus4E),
.clk(clk),

.RegWriteM(RegWriteM),
.ResultSrcM(ResultSrcM),
.MemWriteM(MemWriteM),
.ALUResultM(ALUResultM),
.WriteDataM(WriteDataM),
.RdM(RdM),
.PCPlus4M(PCPlus4M),
.rst(rst)
    );
    wire [31:0] RD;
    data_memory k11 (.ALUResultM(ALUResultM), .WriteDataM(WriteDataM),.clk(clk),
.RD(RD), .MemWriteM(MemWriteM)
    );
   wire [1:0] ResultSrcW;wire [31:0] ALUResultW;
    wire[31:0]ReadDataW;wire [31:0]PCPlus4W;
    MEM_WB k12 (.clk(clk),.RegWriteM(RegWriteM) ,.ResultSrcM(ResultSrcM),.ALUResultM(ALUResultM),
.ReadDataM(RD),.PCPlus4M(PCPlus4M),.RegWriteW(RegWriteW) ,
.ResultSrcW(ResultSrcW),.ALUResultW(ALUResultW),
.ReadDataW(ReadDataW),.PCPlus4W(PCPlus4W),.rst(rst),.RdW(RdW),.RdM(RdM)

);
result_mux k13(.ALUResultW(ALUResultW),.ReadDataW(ReadDataW),.PCPlus4W(PCPlus4W),
.ResultSrcW(ResultSrcW),
.ResultW(ResultW)

    );
    hazard_unit k19 (.Rs1E(Rs1E),.Rs2E(Rs2E), .Rs1D(Rs1D),.Rs2D(Rs2D),
.ResultSrcE0(ResultSrcE[0]),
.RegWriteW(RegWriteW), .RegWriteM(RegWriteM),.RdW(RdW),.RdM(RdM),.RdE(RdE) ,.PCSrcE(PCSrcE),
.StallF(StallF),.StallD(StallD),.FlushD(FlushD),
.FlushE(FlushE), .ForwardAE(ForwardAE),.ForwardBE(ForwardBE)

    );
 
endmodule

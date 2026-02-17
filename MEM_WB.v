`timescale 1ns / 1ps 
module MEM_WB(input clk,input RegWriteM ,input [1:0]ResultSrcM,input [31:0]ALUResultM, 
input [31:0]ReadDataM,input [31:0]PCPlus4M,output reg RegWriteW , 
output reg [1:0]ResultSrcW,output reg [31:0]ALUResultW, 
output reg [31:0]ReadDataW,output reg[31:0]PCPlus4W ,input[4:0] RdM,output reg  [4:0]RdW,
input rst
 
    ); 
    always @ ( posedge clk)begin 
    if (rst)begin
    RegWriteW <= 1'b0; 
    ResultSrcW <= 2'b0; 
    ALUResultW <= 32'b0; 
    ReadDataW <= 32'b0; 
    PCPlus4W <= 32'b0;
    RdW <= 5'b0;   
    end else begin  
    RegWriteW <= RegWriteM; 
    ResultSrcW <= ResultSrcM; 
    ALUResultW <= ALUResultM; 
    ReadDataW <= ReadDataM; 
    PCPlus4W <= PCPlus4M;
    RdW <= RdM;   
    end 
    end
endmodule 

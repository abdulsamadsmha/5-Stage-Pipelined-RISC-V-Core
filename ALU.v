`timescale 1ns / 1ps
module ALU(input [31:0] SrcAE,input [31:0] SrcBE,input [2:0] ALUControlE,
output reg [31:0] ALUResultE
,output reg ZeroE
    );
    always@(*)begin
    case(ALUControlE)
    3'b000:ALUResultE = SrcAE + SrcBE;
    3'b001:begin 
    ALUResultE = SrcAE - SrcBE;
    end
    3'b010:ALUResultE = SrcAE & SrcBE;
    3'b011:ALUResultE = SrcAE | SrcBE;
    default:ALUResultE = 32'b0;   
    endcase
    if (ALUResultE == 32'b0) ZeroE = 1'b1;
    else ZeroE = 1'b0;
    end
endmodule

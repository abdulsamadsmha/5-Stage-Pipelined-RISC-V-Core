`timescale 1ns / 1ps
module IF_ID(input StallD,input FlushD,input clk,input [31:0]PCF,
input [31:0]PCPlus4F,
input[31:0] InstrF,output
reg [31:0]InstrD,output reg[31:0]PCD,output reg[31:0] PCPlus4D,input rst

    );
    always@(posedge clk )begin
    if (rst)begin
    PCD <= 32'b0;
    PCPlus4D <= 32'b0;
    InstrD <= 32'h00000013;
    end
    else if (FlushD)begin
    PCD <= 32'b0;
    PCPlus4D <= 32'b0;
    InstrD <= 32'h00000013;
    end
    else if (~StallD)begin
    PCD <= PCF;
    PCPlus4D <= PCPlus4F;
    InstrD<=InstrF;
    end
    end
endmodule

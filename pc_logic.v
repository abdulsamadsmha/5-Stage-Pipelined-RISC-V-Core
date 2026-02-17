`timescale 1ns / 1ps
module pc_logic(input clk,input StallF,input PCSrcE,
output reg [31:0]PCF,input[31:0] PCTargetE
,input rst 
    );
    always @(posedge clk)begin
    if (rst )begin
    PCF <= 32'b0;
    end else if(~StallF)begin
    case(PCSrcE)
    1'b0:PCF <= PCF+4;
    1'b1:PCF <= PCTargetE;
    endcase
    end
    end
endmodule

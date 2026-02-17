`timescale 1ns / 1ps
module ALUDecoder(input [2:0]funct3,input funct7_5,input op_5,input [1:0]ALUOp,
output reg [2:0]ALUControlD
    );
    always @(*)begin
    case(ALUOp)
    2'b00:ALUControlD = 3'b000;
    2'b01:ALUControlD = 3'b001;
    2'b10:begin
    case(funct3)
    3'b000:begin if(op_5&funct7_5) 
    ALUControlD = 3'b001;
    else
    ALUControlD = 3'b000;
    end
    3'b111:ALUControlD = 3'b010;
    3'b110:ALUControlD = 3'b011; 
    default:ALUControlD = 3'b000; 
    endcase
    end
    default:ALUControlD = 3'b000;
    endcase
    end
endmodule

`timescale 1ns / 1ps
module data_memory(input [31:0]ALUResultM, input [31:0] WriteDataM,input clk,
output [31:0]RD, input MemWriteM
    );
    reg [31:0] data_mem [0:63];
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            data_mem[i] = 32'h00000000;
        end
    end
    always @ (posedge clk) begin
    if (MemWriteM)begin
    data_mem [ALUResultM[7:2]] <= WriteDataM;
    end
    end
    assign RD = data_mem [ALUResultM[7:2]] ;
endmodule

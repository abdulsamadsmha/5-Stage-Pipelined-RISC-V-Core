`timescale 1ns / 1ps
module instruction_memory(input [31:0]A,output [31:0]RD

    );
    reg [31:0]instr_mem[63:0];
    initial begin
    $readmemh ("program.hex",instr_mem);
    end
    assign RD = instr_mem[A[7:2]];
endmodule

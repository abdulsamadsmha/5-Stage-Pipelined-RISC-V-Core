`timescale 1ns / 1ps

module branch_target (
    input  [31:0] PCE,
    input  [31:0] ImmExtE,
    output [31:0] PCTargetE
);
    assign PCTargetE = PCE + ImmExtE;
endmodule

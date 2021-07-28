`include "global_define.vh"
`timescale 1ns / 1ps
module wb(
    input [31:0] d1,
    input [31:0] d2,
    input mem_to_regfile,
    input [31:0] i_except,

    output [31:0] dataout,
    output wb_except
);

    assign wb_except = i_except == 32'd0 ? 1'b0 : 1'b1;

    assign dataout = mem_to_regfile ? d1 : d2;

endmodule
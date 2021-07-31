`include "global_define.vh"
`timescale 1ns / 1ps
module wb(
    input [31:0] d1,
    input [31:0] d2,
    input mem_to_regfile,
    input [6:0] i_except,
    input i_write_from_cp0,
    input [31:0] cp0_data,

    output [31:0] dataout_final,
    output wb_except,
    output [4:0] wb_excode
);
    wire [31:0] dataout;

    assign excode = (i_except == 7'b0000001 ? 5'h00 :(
                     i_except == 7'b0000010 ? 5'h04 :(
                     i_except == 7'b0000100 ? 5'h05 :(
                     i_except == 7'b0001000 ? 5'h0c :(
                     i_except == 7'b0010000 ? 5'h08 :(
                     i_except == 7'b0100000 ? 5'h09 :(
                     i_except == 7'b1000000 ? 5'h0a : 5'h00
                     )
                     )
                     )
                     )
                     )
    ));
    assign wb_except = i_except == 7'd0 ? 1'b0 : 1'b1;

    assign dataout = mem_to_regfile ? d1 : d2;
    assign dataout_final = i_write_from_cp0 ? cp0_data : dataout;

endmodule
`include "global_define.vh"
`timescale 1ns / 1ps
module mem_wb(
    input clk,
    input reset,
    input [5:0] stall,
    input [31:0] i_d1,
    input [31:0] i_d2,
    input [4:0] i_rn,
    input i_write_regfile,
    input i_mem_to_regfile,
    input [31:0] i_hi,
    input [31:0] i_lo,
    input i_write_hilo,
    output reg [31:0] o_d1,
    output reg[31:0] o_d2,
    output reg [4:0] o_rn,
    output reg o_write_regfile,
    output reg o_mem_to_regfile,
    output reg [31:0] o_hi,
    output reg [31:0] o_lo,
    output reg o_write_hilo
);

    always @(posedge clk) begin
        if(reset) begin
            o_d1 <= `ZeroWord;
            o_d2 <= `ZeroWord;
            o_rn <= 5'b00000;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_hi <= `ZeroWord;
            o_lo <= `ZeroWord;
            o_write_hilo <= `ZeroBit;
        end else if(stall[4] == `Stop && stall[5] == `NoStop) begin
            o_d1 <= `ZeroWord;
            o_d2 <= `ZeroWord;
            o_rn <= 5'b00000;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_hi <= `ZeroWord;
            o_lo <= `ZeroWord;
            o_write_hilo <= `ZeroBit;
        end else if(stall[4] == `NoStop) begin
            o_d1 <= i_d1;
            o_d2 <= i_d2;
            o_rn <= i_rn;
            o_write_regfile <= i_write_regfile;
            o_mem_to_regfile <= i_mem_to_regfile;
            o_hi <= i_hi;
            o_lo <= o_lo;
            o_write_hilo <= i_write_hilo;
        end
    end

endmodule
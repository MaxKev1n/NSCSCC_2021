`include "global_define.vh"
`timescale 1ns / 1ps
module exe_mem(
    input clk,
    input reset,
    input [5:0] stall,
    input i_write_mem,
    input i_write_regfile,
    input i_mem_to_regfile,
    input [31:0] i_da,
    input [31:0] i_db,
    input [4:0] i_rn,
    input [7:0] i_mem_control,
    input [31:0] i_hi,
    input [31:0] i_lo,
    input i_write_hilo,
    output reg o_write_mem,
    output reg o_write_regfile,
    output reg o_mem_to_regfile,
    output reg [31:0] o_da,
    output reg [31:0] o_db,
    output reg [4:0] o_rn,
    output reg [7:0] o_mem_control,
    output reg [31:0] o_hi,
    output reg [31:0] o_lo,
    output o_write_hilo
);

    always @(posedge clk) begin
        if(reset) begin
            o_write_mem <= `ZeroBit;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_da <= `ZeroWord;
            o_db <= `ZeroWord;
            o_rn <= 5'b00000;
            o_mem_control <= 8'd0;
            o_hi <= `ZeroWord;
            o_lo <= `ZeroWord;
            o_write_hilo <= `ZeroBit;
        end else if(stall[3] == `Stop && stall[3] == `NoStop) begin
            o_write_mem <= `ZeroBit;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_da <= `ZeroWord;
            o_db <= `ZeroWord;
            o_rn <= 5'b00000;
            o_mem_control <= 8'd0;
            o_hi <= `ZeroWord;
            o_lo <= `ZeroWord;
            o_write_hilo <= `ZeroBit;
        end else if(stall[3] == `NoStop) begin
            o_write_mem <= i_write_mem;
            o_write_regfile <= i_write_regfile;
            o_mem_to_regfile <= i_mem_to_regfile;
            o_da <= i_da;
            o_db <= i_db;
            o_rn <= i_rn;
            o_mem_control <= i_mem_control;
            o_hi <= i_hi;
            o_lo <= o_lo;
            o_write_hilo <= i_write_hilo;
        end
    end

endmodule
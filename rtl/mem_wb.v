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
    input i_mtc0_we,
    input [4:0] i_c0_addr,
    input [31:0] i_except,
    input i_bd,

    output reg [31:0] o_d1,
    output reg[31:0] o_d2,
    output reg [4:0] o_rn,
    output reg o_write_regfile,
    output reg o_mem_to_regfile,
    output reg o_mtc0_we,
    output reg [4:0] o_c0_addr,
    output reg [31:0] o_except,
    output reg o_bd
);

    always @(posedge clk) begin
        if(reset) begin
            o_d1 <= `ZeroWord;
            o_d2 <= `ZeroWord;
            o_rn <= 5'b00000;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_mtc0_we <= `ZeroBit;
            o_except <= `ZeroWord;
            o_c0_addr <= 5'b00000;
            o_bd <= `ZeroBit;
        end else if(stall[4] == `Stop && stall[5] == `NoStop) begin
            o_d1 <= `ZeroWord;
            o_d2 <= `ZeroWord;
            o_rn <= 5'b00000;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_mtc0_we <= `ZeroBit;
            o_except <= `ZeroWord;
            o_c0_addr <= 5'b00000;
            o_bd <= `ZeroBit;
        end else if(stall[4] == `NoStop) begin
            o_d1 <= i_d1;
            o_d2 <= i_d2;
            o_rn <= i_rn;
            o_write_regfile <= i_write_regfile;
            o_mem_to_regfile <= i_mem_to_regfile;
            o_mtc0_we <= i_mtc0_we;
            o_except <= i_except;
            o_c0_addr <= i_c0_addr;
            o_bd <= i_bd;
        end
    end

endmodule
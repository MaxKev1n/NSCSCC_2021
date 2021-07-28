`include "global_define.vh"
`timescale 1ns / 1ps
module id_exe(
    input clk,
    input reset,
    input [5:0] stall,
    input i_write_mem,
    input i_write_regfile,
    input i_mem_to_regfile,
    input i_jal,
    input i_aluimm,
    input i_shift,
    input [31:0] i_pc,
    input [31:0] i_da,
    input [31:0] i_db,
    input [31:0] i_imm,
    input [4:0] i_rn,
    input [22:0] i_ALUControl,
    input [7:0] i_mem_control,
    input i_mtc0_we,
    input [4:0] i_c0_addr,
    input [31:0] i_except,
    input i_next_is_delayslot,
    input i_bd,

    output reg o_write_mem,
    output reg o_write_regfile,
    output reg o_mem_to_regfile,
    output reg o_jal,
    output reg o_aluimm,
    output reg o_shift,
    output reg [31:0] o_pc,
    output reg [31:0] o_da,
    output reg [31:0] o_db,
    output reg [31:0] o_imm,
    output reg [4:0] o_rn,
    output reg [22:0] o_ALUControl,
    output reg [7:0] o_mem_control,
    output reg o_mtc0_we,
    output reg [4:0] c0_addr,
    output reg o_except,
    output reg o_next_is_delayslot,
    output reg o_bd
);

    always @(posedge clk) begin
        if(reset) begin
        o_write_mem <= `ZeroBit;
        o_write_regfile <= `ZeroBit;
        o_mem_to_regfile <= `ZeroBit;
        o_jal <= `ZeroBit;
        o_aluimm <= `ZeroBit;
        o_shift <= `ZeroBit;
        o_pc <= `ZeroWord;
        o_da <= `ZeroWord;
        o_db <= `ZeroWord;
        o_imm <= `ZeroWord;
        o_rn <= 5'b00000;
        o_ALUControl <= 15'd0;
        o_mem_control <= 8'd0;
        o_mtc0_we <= `ZeroBit;
        o_except <= `ZeroWord;
        o_c0_addr <= 5'b00000;
        o_next_is_delayslot <= `ZeroBit;
        o_bd <= `ZeroBit;
    end else if(stall[2] == `Stop && stall[3] == `NoStop) begin
        o_write_mem <= `ZeroBit;
        o_write_regfile <= `ZeroBit;
        o_mem_to_regfile <= `ZeroBit;
        o_jal <= `ZeroBit;
        o_aluimm <= `ZeroBit;
        o_shift <= `ZeroBit;
        o_pc <= `ZeroWord;
        o_da <= `ZeroWord;
        o_db <= `ZeroWord;
        o_imm <= `ZeroWord;
        o_rn <= 5'b00000;
        o_ALUControl <= 15'd0;
        o_mem_control <= 8'd0;
        o_mtc0_we <= `ZeroBit;
        o_except <= `ZeroWord;
        o_c0_addr <= 5'b00000;
        o_next_is_delayslot <= `ZeroBit;
        o_bd <= `ZeroBit;
    end else if(stall[2] == `NoStop) begin
        o_write_mem <= i_write_mem;
        o_write_regfile <= i_write_regfile;
        o_mem_to_regfile <= i_mem_to_regfile;
        o_jal <= i_jal;
        o_aluimm <= i_aluimm;
        o_shift <= i_shift;
        o_pc <= i_pc;
        o_da <= i_da;
        o_db <= i_db;
        o_imm <= i_imm;
        o_rn <= i_rn;
        o_ALUControl <= i_ALUControl;
        o_mem_control <= i_mem_control;
        o_mtc0_we <= i_mtc0_we;
        o_except <= i_except;
        o_c0_addr <= i_c0_addr;
        o_next_is_delayslot <= i_next_is_delayslot;
        o_bd <= i_bd;
    end
    end

endmodule
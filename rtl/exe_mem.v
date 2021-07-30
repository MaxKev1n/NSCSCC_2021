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
    input i_mtc0_we,
    input [4:0] i_c0_addr,
    input [6:0] i_except,
    input i_bd,
    input i_eret,
    input flush,

    output reg o_write_mem,
    output reg o_write_regfile,
    output reg o_mem_to_regfile,
    output reg [31:0] o_da,
    output reg [31:0] o_db,
    output reg [4:0] o_rn,
    output reg [7:0] o_mem_control,
    output reg o_mtc0_we,
    output reg [4:0] o_c0_addr,
    output reg [6:0] o_except,
    output reg o_bd,
    output reg o_eret
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
            o_mtc0_we <= `ZeroBit;
            o_except <= `ZeroWord;
            o_c0_addr <= 5'b00000;
            o_bd <= `ZeroBit;
            o_eret <= `ZeroBit;
        end else if(flush) begin
            o_write_mem <= `ZeroBit;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_da <= `ZeroWord;
            o_db <= `ZeroWord;
            o_rn <= 5'b00000;
            o_mem_control <= 8'd0;
            o_mtc0_we <= `ZeroBit;
            o_except <= `ZeroWord;
            o_c0_addr <= 5'b00000;
            o_bd <= `ZeroBit;
            o_eret <= `ZeroBit;
        end else if(stall[3] == `Stop && stall[3] == `NoStop) begin
            o_write_mem <= `ZeroBit;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_da <= `ZeroWord;
            o_db <= `ZeroWord;
            o_rn <= 5'b00000;
            o_mem_control <= 8'd0;
            o_mtc0_we <= `ZeroBit;
            o_except <= `ZeroWord;
            o_c0_addr <= 5'b00000;
            o_bd <= `ZeroBit;
            o_eret <= `ZeroBit;
        end else if(stall[3] == `NoStop) begin
            o_write_mem <= i_write_mem;
            o_write_regfile <= i_write_regfile;
            o_mem_to_regfile <= i_mem_to_regfile;
            o_da <= i_da;
            o_db <= i_db;
            o_rn <= i_rn;
            o_mem_control <= i_mem_control;
            o_mtc0_we <= i_mtc0_we;
            o_except <= i_except;
            o_c0_addr <=i_c0_addr;
            o_bd <= i_bd;
            o_eret <= i_eret;
        end
    end

endmodule
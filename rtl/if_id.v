`include "global_define.vh"
`timescale 1ns / 1ps
module if_id(
    input clk,
    input reset,
    input [31:0] i_pc,
    input [31:0] i_inst,
    input [5:0] stall,
    input [31:0] i_except,
    output reg [31:0] o_pc,
    output reg [31:0] o_inst,
    output reg [31:0] o_except
);

    always @(posedge clk) begin
        if(reset) begin
            o_pc <= `ZeroWord;
            o_inst <= `ZeroWord;
            o_except <= `ZeroWord;
        end else if(stall[1] == `Stop && stall[2] == `NoStop) begin
            o_pc <= `ZeroWord;
            o_inst <= `ZeroWord;
            o_except <= `ZeroWord;
        end else if(stall[1] == `NoStop) begin
            o_pc <= i_pc;
            o_inst <= i_inst;
            o_except <= i_except;
        end
    end

endmodule
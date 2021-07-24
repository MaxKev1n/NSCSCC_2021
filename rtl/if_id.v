`include "global_define.vh"
`timescale 1ns / 1ps
module if_id(
    input clk,
    input reset,
    input [31:0] i_pc,
    input [31:0] i_inst,
    input [5:0] stall,
    output reg [31:0] o_pc,
    output reg [31:0] o_inst
);

    always @(posedge clk) begin
        if(reset) begin
            o_pc <= `ZeroWord;
            o_inst <= `ZeroWord;
        end else if(stall[1] == `Stop && stall[2] == `NoStop) begin
            o_pc <= `ZeroWord;
            o_inst <= `ZeroWord;
        end else if(stall[1] == `NoStop) begin
            o_pc <= i_pc;
            o_inst <= i_inst;
        end
    end

endmodule
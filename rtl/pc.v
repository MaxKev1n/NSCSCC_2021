`include "global_define.vh"
`timescale 1ns / 1ps
module pc(
    input clk,
    input reset,
    input [5:0] stall,
    input [31:0] i_pc,
    input flush,
    output reg [31:0] o_pc,
    output reg [6:0] o_except
);

    always @(posedge clk) begin
        if(reset) begin
            o_pc <= `ZeroWord;
            o_except <= `ZeroWord;
        end else if(flush) begin
            o_pc <= `ZeroWord;
        end else if(stall[0] == `Stop && stall[1] == `NoStop) begin
            o_pc <= `ZeroWord;
        end else if(stall[0] == `NoStop) begin
            o_pc <= i_pc;
            o_except <= {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, AdEL, 1'b0};
        end
    end

    wire AdEL = pc[1:0] == 2'b00 ? 1'b0 : 1'b1

endmodule
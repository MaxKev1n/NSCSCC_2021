`include "global_define.vh"
`timescale 1ns / 1ps
module regfile(
    input clk,
    input reset,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [31:0] i_data,
    input ena,
    output reg [31:0] o_output1,
    output reg [31:0] o_output2
);

    reg [31:0] regs[0:31];
    integer i;

    always @(posedge clk) begin
        if(reset) begin
            regs[0] <= `ZeroWord;
            regs[1] <= `ZeroWord;
            regs[2] <= `ZeroWord;
            regs[3] <= `ZeroWord;
            regs[4] <= `ZeroWord;
            regs[5] <= `ZeroWord;
            regs[6] <= `ZeroWord;
            regs[7] <= `ZeroWord;
            regs[8] <= `ZeroWord;
            regs[9] <= `ZeroWord;
            regs[10] <= `ZeroWord;
            regs[11] <= `ZeroWord;
            regs[12] <= `ZeroWord;
            regs[13] <= `ZeroWord;
            regs[14] <= `ZeroWord;
            regs[15] <= `ZeroWord;
            regs[16] <= `ZeroWord;
            regs[17] <= `ZeroWord;
            regs[18] <= `ZeroWord;
            regs[19] <= `ZeroWord;
            regs[20] <= `ZeroWord;
            regs[21] <= `ZeroWord;
            regs[22] <= `ZeroWord;
            regs[23] <= `ZeroWord;
            regs[24] <= `ZeroWord;
            regs[25] <= `ZeroWord;
            regs[26] <= `ZeroWord;
            regs[27] <= `ZeroWord;
            regs[28] <= `ZeroWord;
            regs[29] <= `ZeroWord;
            regs[30] <= `ZeroWord;
            regs[31] <= `ZeroWord;
        end else if(ena & (waddr != 5'd0)) begin
            regs[waddr] <= i_data;
        end
    end

    always @(*) begin
        if(reset) begin
            o_output1 <= `ZeroWord;
        end else if(raddr1 == 5'b00000) begin
            o_output1 <= `ZeroWord;
        end else begin
            o_output1 <= regs[raddr1];
        end
    end

    always @(*) begin
        if(reset) begin
            o_output2 <= `ZeroWord;
        end else if(raddr2 == 5'b00000) begin
            o_output2 <= `ZeroWord;
        end else begin
            o_output2 <= regs[raddr2];
        end
    end

endmodule
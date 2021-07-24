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
    output [31:0] o_output1,
    output [31:0] o_output2
);

    reg [31:0] Regfile[0:31];
    integer i;

    always @(posedge clk) begin
        if(reset) begin
            for(i = 1;i < 32;i = i + 1) begin
                Regfile[i] <= 32'd0;
            end
        end else if(ena & (waddr != 5'd0)) begin
            Regfile[waddr] <= i_data;
        end
    end

    assign o_output1 = raddr1 == 5'd0 ? 32'd0 : Regfile[raddr1];
    assign o_output2 = raddr2 == 5'd0 ? 32'd0 : Regfile[raddr2];

endmodule
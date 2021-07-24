`include "global_define.vh"
module pc(
    input clk,
    input reset,
    input [5:0] stall,
    input [31:0] i_pc,
    output reg [31:0] o_pc
);

    always @(posedge clk) begin
        if(reset) begin
            o_pc <= `ZeroWord;
        end else if(stall[0] == `Stop && stall[1] == `NoStop) begin
            o_pc <= `ZeroWord;
        end else if(stall[0] == `NoStop) begin
            o_pc <= i_pc;
        end
    end

endmodule
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
    output o_write_mem,
    output o_write_regfile,
    output o_mem_to_regfile,
    output [31:0] o_da,
    output [31:0] o_db,
    output [4:0] o_rn
);

    always @(posedge clk) begin
        if(reset) begin
            o_write_mem <= `ZeroBit;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_da <= `ZeroWord;
            o_db <= `ZeroWord;
            o_rn <= 5'b00000;
        end else if(stall[3] == `Stop && stall[3] == `NoStop) begin
            o_write_mem <= `ZeroBit;
            o_write_regfile <= `ZeroBit;
            o_mem_to_regfile <= `ZeroBit;
            o_da <= `ZeroWord;
            o_db <= `ZeroWord;
            o_rn <= 5'b00000;
        end else if(stall[3] == `NoStop) begin
            o_write_mem <= i_write_mem;
            o_write_regfile <= i_write_regfile;
            o_mem_to_regfile <= i_mem_to_regfile;
            o_da <= i_da;
            o_db <= i_db;
            o_rn <= i_rn;
        end
    end

endmodule
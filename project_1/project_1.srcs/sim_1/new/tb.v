`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/24 19:05:02
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(

    );

    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] inst;
    wire [31:0] ALURes;
    wire [31:0] id_da;
    wire [31:0] id_db;

    top TOP(.clk(clk), .reset(reset), .stall(6'b000000), .pc(pc), .inst(inst), .ALURes(ALURes), .id_da(id_da), .id_db(id_db));

    initial begin
        reset = 1'b0;
        clk = 1'b0;

        #10 reset = 1'b1;
        #10 reset = 1'b0;
    end

    always begin
        #10 clk = ~clk;
    end


endmodule

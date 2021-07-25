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
    wire [31:0] pc4;
    wire [31:0] inst;
    wire [31:0] if_id_inst;
    wire [31:0] ALURes;
    wire [31:0] id_da;
    wire [31:0] id_db;
    wire [31:0] id_exe_imm;
    wire [31:0] mem_wb_d1;
    wire [31:0] mem_wb_d2;
    wire [31:0] wdata;
    wire [4:0] waddr;
    wire wb_write_regfile;
    wire [31:0] data_ram_out;
    wire [31:0] exe_mem_da;


    top TOP(.clk(clk), .reset(reset), .stall(6'b000000), .pc(pc), .pc4(pc4), .inst(inst), .if_id_inst(if_id_inst), .ALURes(ALURes), .id_da(id_da), .id_db(id_db), .id_exe_imm(id_exe_imm),
            .mem_wb_d1(mem_wb_d1), .mem_wb_d2(mem_wb_d2), .wdata(wdata), .waddr(waddr), .wb_write_regfile(wb_write_regfile), .data_ram_out(data_ram_out), .exe_mem_da(exe_mem_da));

    initial begin
        reset = 1'b0;
        clk = 1'b0;

        #5 reset = 1'b1;
        #6 reset = 1'b0;
    end

    always begin
        #10 clk = ~clk;
    end


endmodule

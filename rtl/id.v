`include "global_define.vh"
`timescale 1ns / 1ps
module ID(
    input [31:0] i_inst,
    input clk,
    input reset,
    input [31:0] i_pc,
    input [4:0] exe_reg,
    input [4:0] mem_reg,
    input exe_mem_to_regfile,
    input mem_mem_to_regfile,
    input exe_write_regfile,
    input mem_write_regfile,
    input [31:0] qa,
    input [31:0] qb,
    input [31:0] ALUres,
    input [31:0] exe_mem_data,
    input [31:0] mem_data,

    output [31:0] imm,
    output [4:0] rn,
    output write_mem,
    output write_regfile,
    output mem_to_regfile,
    output jal,
    output aluimm,
    output shift,
    output [31:0] bpc,
    output [31:0] jpc,
    output [31:0] jrpc,
    output [1:0] pcsource,
    output [22:0] ALUControl,
    output [7:0] mem_control,
    output [31:0] da,
    output [31:0] db
);
    wire rs_eq_rt;
    wire rd_or_rt;
    wire [1:0] fwda, fwdb;
    wire [31:0] qa, qb;

    assign rs_eq_rt = qa == qb ? 1'b1 : 1'b0;

    control_unit CU(.inst(i_inst), .pc(i_pc), .rs_eq_rt(rs_eq_rt), .exe_reg(exe_reg), .mem_reg(mem_reg),
                    .exe_mem_to_regfile(exe_mem_to_regfile), 
                    .mem_mem_to_regfile(mem_mem_to_regfile), .exe_write_regfile(exe_write_regfile), 
                    .mem_write_regfile(mem_write_regfile), .write_mem(write_mem), .write_regfile(write_regfile),
                    .mem_to_regfile(mem_to_regfile), .jal(jal), .aluimm(aluimm), .shift(shift), .sext(sext),
                    .rd_or_rt(rd_or_rt), .fwda(fwda), .fwdb(fwdb), .bpc(bpc), .jpc(jpc), .pcsource(pcsource),
                    .ALUControl(ALUControl), .mem_control(mem_control));

    mux4x32 MUX1(.a0(qa), .a1(ALUres), .a2(exe_mem_data), .a3(mem_data), .s(fwda), .res(da));
    mux4x32 MUX2(.a0(qb), .a1(ALUres), .a2(exe_mem_data), .a3(mem_data), .s(fwdb), .res(db));

    assign imm = sext ? {{16{i_inst[15]}}, i_inst[15:0]} : {16'd0, i_inst[15:0]};
    assign rn = rd_or_rt ? i_inst[15:11] : i_inst[20:16];
    assign jrpc = da;

endmodule
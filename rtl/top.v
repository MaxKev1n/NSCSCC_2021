`include "global_define.vh"
`timescale 1ns / 1ps
module top(
    input clk,
    input reset,
    input [5:0] stall,
    output [31:0] pc,
    output [31:0] pc4,
    output [31:0] inst,
    output [31:0] if_id_inst,
    output [31:0] ALURes,
    output [31:0] id_da,
    output [31:0] id_db,
    output [31:0] id_exe_imm,
    output [31:0] mem_wb_d1,
    output [31:0] mem_wb_d2,
    output [31:0] wdata,
    output [4:0] waddr,
    output wb_write_regfile,
    output [31:0] data_ram_out,
    output [31:0] exe_mem_da,
    output [1:0] pcsource,
    output [31:0] jrpc
);

    wire [31:0] npc;
    wire [1:0] pcsource;
    wire [31:0] bpc;
    wire [31:0] jpc;
    wire [31:0] jrpc;
    wire [31:0] pc4;
    wire [31:0] if_id_pc;
    wire [31:0] if_id_inst;
    wire [31:0] reg_da;
    wire [31:0] reg_db;
    wire [4:0] exe_reg;
    wire [4:0] mem_reg;
    wire wb_write_regfile;
    wire exe_mem_to_regfile;
    wire mem_mem_to_regfile;
    wire exe_write_regfile;
    wire mem_write_regfile;
    wire [4:0] waddr;
    wire [31:0] wdata;
    wire [31:0] id_da;
    wire [31:0] id_db;
    wire [31:0] id_imm;
    wire [4:0] id_rn;
    wire id_write_mem;
    wire id_write_regfile;
    wire id_mem_to_regfile;
    wire id_jal;
    wire id_aluimm;
    wire id_shift;
    wire [22:0] id_ALUControl;
    wire [7:0] id_mem_control;
    wire id_exe_write_mem;
    wire id_exe_write_regfile;
    wire id_exe_mem_to_regfile;
    wire id_exe_jal;
    wire id_exe_aluimm;
    wire id_exe_shift;
    wire [31:0] id_exe_pc;
    wire [31:0] id_exe_da;
    wire [31:0] id_exe_db;
    wire [31:0] id_exe_imm;
    wire [22:0] id_exe_ALUControl;
    wire [7:0] id_exe_mem_control;
    wire [31:0] ea;
    wire [31:0] eb;
    wire [31:0] hi;
    wire [31:0] lo;
    wire write_hi;
    wire write_lo;
    wire [4:0] ern;
    wire exe_mem_write_mem;
    wire exe_mem_write_regfile;
    wire exe_mem_mem_to_regfile;
    wire [31:0] exe_mem_da;
    wire [31:0] exe_mem_db;
    wire [7:0] exe_mem_mem_control;
    wire [31:0] mem_dout;
    wire [3:0] store_control;
    wire [31:0] data_ram_out;
    wire [31:0] mem_wb_d1;
    wire [31:0] mem_wb_d2;
    wire mem_wb_mem_to_regfile;
    wire [31:0] reg_hilo_hi;
    wire [31:0] reg_hilo_lo;

    pc PC(.clk(clk), .reset(reset), .stall(stall), .i_pc(npc), .o_pc(pc));

    If IF(.i_pc(pc), .pcsource(pcsource), .bpc(bpc), .jpc(jpc), .jrpc(jrpc), .pc4(pc4), .inst(inst), .npc(npc));

    if_id IF_ID(.clk(clk), .reset(reset), .i_pc(pc4), .i_inst(inst), .stall(stall), .o_pc(if_id_pc), .o_inst(if_id_inst));

    ID ID(.i_inst(if_id_inst), .clk(clk), .reset(reset), .i_pc(if_id_pc), .exe_reg(ern), .mem_reg(mem_reg),
          .exe_mem_to_regfile(exe_mem_to_regfile), .mem_mem_to_regfile(mem_mem_to_regfile),
          .exe_write_regfile(exe_write_regfile), .mem_write_regfile(mem_write_regfile),
          .imm(id_imm), .rn(id_rn), .write_mem(id_write_mem), .write_regfile(id_write_regfile),
          .mem_to_regfile(id_mem_to_regfile), .jal(id_jal), .aluimm(id_aluimm), .shift(id_shift), .bpc(bpc), .jpc(jpc), .jrpc(jrpc),
          .pcsource(pcsource), .ALUControl(id_ALUControl), .mem_control(id_mem_control), .qa(reg_da), .qb(reg_db), .ALUres(ALURes),
          .exe_mem_data(exe_mem_da), .mem_data(mem_dout), .da(id_da), .db(id_db));

    regfile REGFILE(.clk(clk), .reset(reset), .raddr1(if_id_inst[25:21]), .raddr2(if_id_inst[20:16]), .waddr(waddr),
                    .i_data(wdata), .ena(wb_write_regfile), .o_output1(reg_da), .o_output2(reg_db));
    
    id_exe ID_EXE(.clk(clk), .reset(reset), .stall(stall), .i_write_mem(id_write_mem), .i_write_regfile(id_write_regfile), .i_jal(id_jal),
                  .i_mem_to_regfile(id_mem_to_regfile), .i_aluimm(id_aluimm), .i_shift(id_shift), .i_pc(if_id_pc), .i_da(id_da), .i_db(id_db), .i_imm(id_imm),
                  .i_rn(id_rn), .i_ALUControl(id_ALUControl), .i_mem_control(id_mem_control), .o_write_mem(id_exe_write_mem),
                  .o_write_regfile(id_exe_write_regfile), .o_mem_to_regfile(id_exe_mem_to_regfile), .o_jal(id_exe_jal), .o_aluimm(id_exe_aluimm),
                  .o_shift(id_exe_shift), .o_pc(id_exe_pc), .o_da(id_exe_da), .o_db(id_exe_db), .o_imm(id_exe_imm), .o_rn(exe_reg),
                  .o_ALUControl(id_exe_ALUControl), .o_mem_control(id_exe_mem_control));

    exe EXE(.clk(clk), .jal(id_exe_jal), .aluimm(id_exe_aluimm), .shift(id_exe_shift), .pc(id_exe_pc), .da(id_exe_da), .db(id_exe_db), .imm(id_exe_imm),
            .ALUControl(id_exe_ALUControl), .i_hi(reg_hilo_hi), .i_lo(reg_hilo_lo), .i_ern(exe_reg), .ea(ALURes), .eb(eb), .hi(hi), .lo(lo), .write_hi(write_hi),
            .write_lo(write_lo), .o_ern(ern));

    exe_mem EXE_MEM(.clk(clk), .reset(reset), .stall(stall), .i_write_mem(id_exe_write_mem), .i_write_regfile(id_exe_write_regfile),
                    .i_mem_to_regfile(id_exe_mem_to_regfile), .i_da(ALURes), .i_db(eb), .i_rn(ern), .i_mem_control(id_exe_mem_control),
                    .o_write_mem(exe_mem_write_mem), .o_write_regfile(exe_mem_write_regfile), .o_mem_to_regfile(exe_mem_mem_to_regfile),
                    .o_da(exe_mem_da), .o_db(exe_mem_db), .o_rn(mem_reg), .o_mem_control(exe_mem_mem_control));
    
    mem MEM(.din(data_ram_out), .addr(exe_mem_da), .mem_control(exe_mem_mem_control), .dout(mem_dout), .store_control(store_control));

    data_ram DATA_RAM(.clka(clk), .rsta(reset), .ena(1'b1), .wea(store_control), .addra(exe_mem_da), .dina(exe_mem_db), .douta(data_ram_out));

    mem_wb MEM_WB(.clk(clk), .reset(reset), .stall(stall), .i_d1(mem_dout), .i_d2(exe_mem_da), .i_rn(mem_reg),
                  .i_write_regfile(exe_mem_write_regfile), .i_mem_to_regfile(exe_mem_mem_to_regfile), .o_d1(mem_wb_d1),
                  .o_d2(mem_wb_d2), .o_rn(waddr), .o_write_regfile(wb_write_regfile), .o_mem_to_regfile(mem_wb_mem_to_regfile));

    wb WB(.d1(mem_wb_d1), .d2(mem_wb_d2), .mem_to_regfile(mem_wb_mem_to_regfile), .dataout(wdata));

    regfile_hilo REGFILE_HILO(.clk(clk), .reset(reset), .ena_hi(write_hi), .ena_lo(write_lo), .i_hi(hi), .i_lo(lo),
                              .o_hi(reg_hilo_hi), .o_lo(reg_hilo_lo));

endmodule
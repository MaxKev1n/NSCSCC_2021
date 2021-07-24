`include "global_define.vh"
`timescale 1ns / 1ps
module top(
    input clk,
    input reset,
    input [5:0] stall,
    output [31:0] pc,
    output [31:0] inst,
    output [31:0] ALURes
);

    wire [31:0] npc;
    wire [1:0] pcsource;
    wire [31:0] bpc;
    wire [31:0] jpc;
    wire [31:0] jrpc;
    wire [31:0] pc4;
    wire [31:0] if_id_pc;
    wire [31:0] if_id_inst;
    wire [4:0] exe_reg;
    wire [4:0] mem_reg;
    wire wb_write_regfile;
    wire exe_mem_to_regfile;
    wire mem_mem_to_regfile;
    wire exe_write_regfile;
    wire mem_write_regfile;
    wire [4:0] waddr;
    wire [4:0] wdata;
    wire [31:0] id_pc;
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
    wire [14:0] id_ALUControl;
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
    wire [14:0] id_exe_ALUControl;
    wire [7:0] id_exe_mem_control;
    wire [31:0] ea;
    wire [31:0] eb;
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
    wire mem_wb_write_regfile;
    wire mem_wb_mem_to_regfile;

    pc PC(.clk(clk), .reset(reset), .stall(stall), .i_pc(npc), .o_pc(pc));

    If IF(.i_pc(pc), .pcsource(pcsource), .bpc(bpc), .jpc(jpc), .jrpc(jrpc), .pc4(pc4), .inst(inst), .npc(npc));

    if_id IF_ID(.clk(clk), .reset(reset), .i_pc(pc4), .i_inst(inst), .stall(stall), .o_pc(if_id_pc), .o_inst(if_id_inst));

    ID ID(.i_inst(if_id_inst), .clk(clk), .reset(reset), .i_pc(if_id_pc), .exe_reg(exe_reg), .mem_reg(mem_reg),
          .wb_write_regfile(wb_write_regfile), .exe_mem_to_regfile(exe_mem_to_regfile), .mem_mem_to_regfile(mem_mem_to_regfile),
          .exe_write_regfile(exe_write_regfile), .mem_write_regfile(mem_write_regfile), .waddr(waddr), .wdata(wdata),
          .o_pc(id_pc), .da(id_da), .db(id_db), .imm(id_imm), .rn(id_rn), .write_mem(id_write_mem), .write_regfile(id_write_regfile),
          .mem_to_regfile(id_mem_to_regfile), .jal(id_jal), .aluimm(id_aluimm), .shift(id_shift), .bpc(bpc), .jpc(jpc), .jrpc(jrpc),
          .pcsource(pcsource), .ALUControl(id_ALUControl), .mem_control(id_mem_control));
    
    id_exe ID_EXE(.clk(clk), .reset(reset), .stall(stall), .i_write_mem(id_write_mem), .i_write_regfile(id_write_regfile), .i_jal(id_jal),
                  .i_aluimm(id_aluimm), .i_shift(id_shift), .i_pc(id_pc), .i_da(id_pc), .i_db(id_db), .i_imm(id_imm), .i_rn(id_rn),
                  .i_ALUControl(id_ALUControl), .i_mem_control(id_mem_control), .o_write_mem(id_exe_write_mem),
                  .o_write_regfile(id_exe_write_regfile), .o_mem_to_regfile(id_exe_mem_to_regfile), .o_jal(id_exe_jal), .o_aluimm(id_exe_aluimm),
                  .o_shift(id_exe_shift), .o_pc(id_exe_pc), .o_da(id_exe_da), .o_db(id_exe_db), .o_imm(id_exe_imm), .o_rn(exe_reg),
                  .o_ALUControl(id_exe_ALUControl), .o_mem_control(id_exe_mem_control));

    exe EXE(.jal(id_exe_jal), .aluimm(id_exe_aluimm), .shift(id_exe_shift), .pc(id_exe_pc), .da(id_exe_da), .db(id_exe_db), .imm(id_exe_imm),
            .ALUControl(id_exe_ALUControl), .ea(ea), .eb(eb));

    exe_mem EXE_MEM(.clk(clk), .reset(reset), .stall(stall), .i_write_mem(id_exe_write_mem), .i_write_regfile(id_exe_write_regfile),
                    .i_mem_to_regfile(id_exe_mem_to_regfile), .i_da(ea), .i_db(eb), .i_rn(exe_reg), .i_mem_control(id_exe_mem_control),
                    .o_write_mem(exe_mem_write_mem), .o_write_regfile(exe_mem_write_regfile), .o_mem_to_regfile(exe_mem_mem_to_regfile),
                    .o_da(exe_mem_da), .o_db(exe_mem_db), .o_rn(mem_reg), .o_mem_control(exe_mem_mem_control));
    
    mem MEM(.din(data_ram_out), .addr(exe_mem_da), .mem_control(exe_mem_mem_control), .dout(mem_dout), .store_control(store_control));

    data_ram DATA_RAM(.clka(clk), .rsta(reset), .ena(1'b1), .wea(store_control), .addra(exe_mem_da), .dina(exe_mem_db), .douta(data_ram_out));

    mem_wb MEM_WB(.clk(clk), .reset(reset), .stall(stall), .i_d1(mem_dout), .i_d2(exe_mem_da), .i_rn(exe_mem_rn),
                  .i_write_regfile(exe_mem_write_regfile), .i_mem_to_regfile(exe_mem_mem_to_regfile), .o_d1(mem_wb_d1), .o_d2(mem_wb_d2),
                  .o_rn(waddr), .o_write_regfile(mem_wb_write_regfile), .o_mem_to_regfile(mem_wb_mem_to_regfile));

    wb WB(.d1(mem_wb_d1), .d2(mem_wb_d2), .mem_to_regfile(mem_wb_mem_to_regfile), .dataout(wdata));

endmodule
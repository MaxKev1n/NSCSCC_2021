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

    pc PC(.clk(clk), .reset(reset), .stall(stall), .i_pc(npc), .o_pc(pc));

    If IF(.pc(pc), .pcsource(pcsource), .bpc(bpc), .jpc(jpc), .jrpc(jrpc), .pc4(pc4), .inst(inst), .npc(npc));

    if_id IF_ID(.clk(clk), .reset(reset), .i_pc(pc4), .i_inst(inst), .stall(stall), .o_pc(if_id_pc), .o_inst(if_id_inst));

    ID ID(.i_inst(if_id_inst), .clk(clk), .reset(reset), .i_pc(if_id_pc), .exe_reg(exe_reg), .mem_reg(mem_reg),
          .wb_write_regfile(wb_write_regfile), .exe_mem_to_regfile(exe_mem_to_regfile), .mem_mem_to_regfile(mem_mem_to_regfile),
          .exe_write_regfile(exe_write_regfile), .mem_write_regfile(mem_write_regfile), .waddr(waddr), .wdata(wdata),
          .o_pc(id_pc), .da(id_da), .db(id_db), .imm(id_imm), .rn(id_rn), .write_mem(id_write_mem), .write_regfile(id_write_regfile),
          .mem_to_regfile(id_mem_to_regfile), .jal(id_jal), .aluimm(id_aluimm), .shift(id_shift), .bpc(bpc), .jpc(jpc), .jrpc(jrpc),
          .pcsource(pcsource), .ALUControl(id_ALUControl), .mem_control(id_mem_control));

    

endmodule
`include "global_define.vh"
`timescale 1ns / 1ps
module exe(
    input jal,
    input aluimm,
    input shift,
    input [31:0] pc,
    input [31:0] da,
    input [31:0] db,
    input [31:0] imm,
    input [14:0] ALUControl,

    output [31:0] ea,
    output [31:0] eb
);

    wire [31:0] pc8;
    wire [31:0] ALU1;
    wire [31:0] ALU2;
    wire [31:0] ALURes;

    assign ALU1 = shift ? imm : da;
    assign ALU2 = aluimm ? imm : db;
    assign pc8 = pc + 4;

    ALU alu(.ALUControl(ALUControl), .da(da), .db(db), .dout(ALURes));
    assign ea = jal ? pc8 : ALURes;
    assign eb = db;

endmodule
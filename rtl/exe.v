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
    reg [31:0] dout;

    assign ALU1 = shift ? imm : da;
    assign ALU2 = aluimm ? imm : db;
    assign pc8 = pc + 32'd4;

    assign ea = jal ? pc8 : dout;
    assign eb = db;

    wire [31:0] complement;
    wire [31:0] res_sum;
    wire [31:0] a_compare_b;

    assign complement = (ALUControl == `SLT || ALUControl == `SUB || ALUControl == `SUBU) ? (~ALU2 + 1) : ALU2;
    assign res_sum = ALU1 + complement;
    assign a_compare_b = (ALUControl == `SLT) ? ((ALU1[31] && db[31] && res_sum[31]) || (ALU1[31] && !ALU2[31]) || (!ALU1[31] && !ALU2[31] && res_sum[31])) : (ALU1 < ALU2);
    
    always @(*) begin
        case(ALUControl)
            `ADD, `ADDU, `SUB, `SUBU : begin
                dout = res_sum;
            end
            `AND : begin
                dout = ALU1 & ALU2;
            end
            `OR : begin
                dout = ALU1 | ALU2;
            end
            `XOR : begin
                dout = ALU1 ^ ALU2;
            end
            `NOR : begin
                dout = ~(ALU1 | ALU2);
            end
            `SLT, `SLTU : begin
                dout = a_compare_b;
            end
            `SLL : begin
                dout = ALU2 << ALU1[4:0];
            end
            `SRL : begin
                dout = ALU2 >> ALU1[4:0];
            end
            `SRA : begin
                dout = ALU2 >>> ALU1[4:0];
            end
            `LUI : begin
                dout = {ALU2[15:0], 16'd0};
            end
            default : begin
                dout = `ZeroWord;
            end
        endcase
    end


endmodule
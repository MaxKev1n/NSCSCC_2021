`include "global_define.vh"
`timescale 1ns / 1ps
module exe(
    input clk,
    input jal,
    input aluimm,
    input shift,
    input [31:0] pc,
    input [31:0] da,
    input [31:0] db,
    input [31:0] imm,
    input [22:0] ALUControl,
    input [31:0] i_hi,
    input [31:0] i_lo,

    output [31:0] ea,
    output [31:0] eb,
    output reg [31:0] hi,
    output reg [31:0] lo,
    output write_hi,
    output write_lo
);

    wire [31:0] pc8;
    wire [31:0] ALU1;
    wire [31:0] ALU2;
    reg [31:0] dout;
    reg s_axis_divisor_tvalid;
    reg s_axis_divisor_tready;
    reg s_axis_dividend_tvalid;
    reg s_axis_dividend_tready;
    reg m_axis_dout_tvalid;
    reg s_axis_divisor_tvalid_u;
    reg s_axis_divisor_tready_u;
    reg s_axis_dividend_tvalid_u;
    reg s_axis_dividend_tready_u;
    reg m_axis_dout_tvalid_u;

    assign ALU1 = shift ? imm : da;
    assign ALU2 = aluimm ? imm : db;
    assign pc8 = pc + 32'd4;

    assign ea = jal ? pc8 : dout;
    assign eb = db;
    assign write_hilo = (ALUControl == `MULT || ALUControl == `MULTU) ? 1'b1 : 1'b0;

    wire [31:0] complement;
    wire [31:0] res_sum;
    wire [31:0] a_compare_b;
    wire [65:0] res_multu;
    wire [65:0] res_mult;
    wire [63:0] res_div;
    wire [63:0] res_div_u;

    assign complement = (ALUControl == `SLT || ALUControl == `SUB || ALUControl == `SUBU) ? (~ALU2 + 1) : ALU2;
    assign res_sum = ALU1 + complement;
    assign a_compare_b = (ALUControl == `SLT) ? ((ALU1[31] && db[31] && res_sum[31]) || (ALU1[31] && !ALU2[31]) || (!ALU1[31] && !ALU2[31] && res_sum[31])) : (ALU1 < ALU2);
    assign write_hi = (ALUControl == `MTHI) ? 1'b1 : 1'b0;
    assign write_lo = (ALUControl == `MTLO) ? 1'b1 : 1'b0;

    unsigned_multiplier UM(.CLK(1'b1), .A({1'b0, {ALU1[31:0]}}), .B({1'b0, {ALU2[31:0]}}), .P(res_multu));
    signed_multiplier SM(.CLK(1'b1), .A({{ALU1[31]}, {ALU1[31:0]}}), .B({{ALU2[31]}, {ALU2[31:0]}}), .P(res_mult));
    divider DIVEDER(.aclk(clk), .s_axis_divisor_tvalid(s_axis_divisor_tvalid), .s_axis_divisor_tready(s_axis_divisor_tready), .s_axis_divisor_tdata(ALU1),
                    .s_axis_dividend_tvalid(s_axis_dividend_tvalid), .s_axis_dividend_tready(s_axis_dividend_tready), .s_axis_dividend_tdata(ALU2),
                    .m_axis_dout_tvalid(m_axis_dout_tvalid), .m_axis_dout_tdata(res_div));
    divider_u DIVIDER_U(.aclk(clk), .s_axis_divisor_tvalid(s_axis_divisor_tvalid_u), .s_axis_divisor_tready(s_axis_divisor_tready_u), .s_axis_divisor_tdata(ALU1),
                    .s_axis_dividend_tvalid(s_axis_dividend_tvalid_u), .s_axis_dividend_tready(s_axis_dividend_tready_u), .s_axis_dividend_tdata(ALU2),
                    .m_axis_dout_tvalid(m_axis_dout_tvalid_u), .m_axis_dout_tdata(res_div_u));

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
            `MULT : begin
                hi = res_mult[63:32];
                lo = res_mult[31:0];
            end
            `MULTU : begin
                hi = res_multu[63:32];
                lo = res_multu[31:0];
            end
            `DIV : begin
                if(m_axis_dout_tvalid == 1'b1) begin
                    hi = res_div[31:0];
                    lo = res_div[63:32];
                end else if(s_axis_dividend_tready && s_axis_divisor_tready) begin
                    s_axis_dividend_tvalid = 1'b0;
                    s_axis_divisor_tvalid = 1'b0;
                end else begin
                    s_axis_dividend_tvalid = 1'b1;
                    s_axis_divisor_tvalid = 1'b1;
                end
            end
            `DIVU : begin
                if(m_axis_dout_tvalid_u == 1'b1) begin
                    hi = res_div_u[31:0];
                    lo = res_div_u[63:32];
                end else if(s_axis_dividend_tready_u && s_axis_divisor_tready_u) begin
                    s_axis_dividend_tvalid_u = 1'b0;
                    s_axis_divisor_tvalid_u = 1'b0;
                end else begin
                    s_axis_dividend_tvalid_u = 1'b1;
                    s_axis_divisor_tvalid_u = 1'b1;
                end
            end
            `MFHI : begin
                hi = i_hi;
            end
            `MFLO : begin
                lo = i_lo;
            end
            `MTHI : begin
                hi = da;
            end
            `MTLO : begin
                lo = da;
            end
            default : begin
                dout = `ZeroWord;
            end
        endcase
    end


endmodule
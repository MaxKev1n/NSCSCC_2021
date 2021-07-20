module exe(
    input jal,
    input aluimm,
    input shift,
    input [31:0] pc,
    input [31:0] da,
    input [31:0] db,
    input [31:0] imm,
    input [4:0] rn,
    input [14:0] ALUControl,

    output [4:0] ern,
    output [31:0] ea,
    output [31:0] eb
);

    wire [31:0] pc8;
    wire [31:0] ALU1;
    wire [31:0] ALU2;
    wire [31:0] ALURes;

    assign ALU1 = shift ? imm : da;
    assign ALU2 = aluimm ? imm : db;

endmodule
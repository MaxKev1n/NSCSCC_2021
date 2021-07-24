module If(
    input [31:0] pc,
    input [1:0] pcsource,
    input [31:0] bpc,
    input [31:0] jpc,
    input [31:0] jrpc,
    output [31:0] pc4,
    output [31:0] inst,
    output [31:0] npc
);

    assign pc4 = pc + 32'd4;
    mux4x32 MUX(.a0(pc4), .a1(jrpc), .a2(jpc), .a3(bpc), .s(pcsource), .res(npc));
    //inst_rom

endmodule
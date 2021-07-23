module wb(
    input [31:0] d1,
    input [31:0] d2,
    input mem_to_regfile,
    output [31:0] dataout
);

    assign dataout = mem_to_regfile ? d2 : d1;

endmodule
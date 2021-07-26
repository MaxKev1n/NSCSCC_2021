module regfile_hilo(
    input clk,
    input reset,
    input ena_hi,
    input ena_lo,
    input [31:0] i_hi,
    input [31:0] i_lo,
    output reg [31:0] o_hi,
    output reg [31:0] o_lo
);

    reg [31:0] hi;
    reg [31:0] lo;

    always @(posedge clk) begin
        if(reset) begin
            hi <= `ZeroWord;
        end else if(ena_hi) begin
            hi <= i_hi;
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            lo <= `ZeroWord;
        end else if(ena_lo) begin
            lo <= i_lo;
        end
    end

    always @(*) begin
        if(reset) begin
            o_hi <= `ZeroWord;
            o_lo <= `ZeroWord;
        end else begin
            o_hi <= hi;
            o_lo <= lo;
        end
    end

endmodule
module crtl(
    input reset,
    input [6:0] i_except,
    input [31:0] i_epc,
    input i_eret,
    output reg flush,
    output reg [5:0] stall,
    output reg [31:0] new_pc
);

    always @(*) begin
        if(reset) begin
            stall = 6'b000000;
            flush = 1'b0;
            new_pc = 32'h00000000;
        end else if(i_except != 7'd0) begin
            stall = 6'b000000;
            flush = 1'b1;
            new_pc = 32'h00000000;
            case(i_except)
                7'b0000001 : begin
                    new_pc = 32'hbfc00380;
                end
                7'b0000010 : begin
                    new_pc = 32'hbfc00380;
                end
                7'b0000100 : begin
                    new_pc = 32'hbfc00380;
                end
                7'b0001000 : begin
                    new_pc = 32'hbfc00380;
                end
                7'b0010000 : begin
                    new_pc = 32'hbfc00380;
                end
                7'b0100000 : begin
                    new_pc = 32'hbfc00380;
                end
                7'b1000000 : begin
                    new_pc = 32'hbfc00380;
                end
            endcase
        end else if(i_eret) begin
            stall = 6'b000000;
            flush = 1'b0;
            new_pc = i_epc;
        end else begin
            stall = 6'b000000;
            flush = 1'b0;
            new_pc = 32'hbfc00380;
        end
    end

endmodule
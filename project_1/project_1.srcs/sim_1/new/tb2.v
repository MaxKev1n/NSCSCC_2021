module tb2();

    reg clk;
    reg [3:0] REGFILE;
    wire [3:0] dout;
    assign dout = REGFILE;
    initial begin
        clk = 1'b0;
        REGFILE = 4'b0000;
    end
    always begin
        #5 clk = ~clk;
            REGFILE <= REGFILE + 1'b1;
    end
endmodule
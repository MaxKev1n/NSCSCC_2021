module tb2();

    reg ena;
    reg clk;
    reg reset;
    reg [4:0] addr;
    reg [31:0] d;
    wire [31:0] dout;

    regfile REGFILE(.clk(clk), .reset(reset), .raddr1(addr), .waddr(addr), .i_data(d), .ena(1'b1), .o_output1(dout));
    initial begin
        reset = 1'b0;
        clk = 1'b0;
        d = 32'd0;
        #5 reset = ~reset;
        #5 reset = ~reset;
    end
    always begin
        #10 clk = ~clk;
            addr = 5'b0001;
            d = d + 32'd1;
    end
endmodule
module tb2();

    reg [14:0] ALUControl;
    reg [31:0] da;
    reg [31:0] db;
    wire [31:0] dout;

    ALU alu(.ALUControl(ALUControl), .da(da), .db(db), .dout(dout));
    initial begin
        da = 32'd0;
        db = 32'd100;
        ALUControl = 15'b010000000000000;
    end
endmodule
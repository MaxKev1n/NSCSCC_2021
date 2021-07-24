`include "global_define.vh"
module ALU(
    input [14:0] ALUControl,
    input [31:0] da,
    input [31:0] db,

    output reg [31:0] dout
);

    wire [31:0] complement;
    wire [31:0] res_sum;
    wire [31:0] a_compare_b;

    assign complement = (ALUControl == `SLT || ALUControl == `SUB || ALUControl == `SUBU) ? (~da + 1) : da;
    assign res_sum = da + complement;
    assign a_compare_b = (ALUControl == `SLT) ? ((da[31] && db[31] && res_sum[31]) || (da[31] && !db[31]) || (!da[31] && !db[31] && res_sum[31])) : (da < db);
    
    always @(*) begin
        case(ALUControl)
            `ADD, `ADDU, `SUB, `SUBU : begin
                dout = res_sum;
            end
            `AND : begin
                dout = da & db;
            end
            `OR : begin
                dout = da | db;
            end
            `XOR : begin
                dout = da ^ db;
            end
            `NOR : begin
                dout = ~(da | db);
            end
            `SLT, `SLTU : begin
                dout = a_compare_b;
            end
            `SLL : begin
                dout = db << da[4:0];
            end
            `SRL : begin
                dout = db >> da[4:0];
            end
            `SRA : begin
                dout = db >>> da[4:0];
            end
            `LUI : begin
                dout = {db[15:0], 16'd0};
            end
            default : begin
                dout = `ZeroWord;
            end
        endcase
    end

endmodule
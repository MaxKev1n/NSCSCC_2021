`include "global_define.vh"
`timescale 1ns / 1ps
module mem(
    input [31:0] din,
    input [31:0] addr,
    input [7:0] mem_control,
    output reg [31:0] dout,
    output reg [3:0] store_control
);

    always @(*) begin
        case(mem_control)
            `MEM_LB : begin
                case(addr[1:0])
                    2'b00 : begin
                        dout = {{24{din[7]}}, din[7:0]};
                    end
                    2'b01 : begin
                        dout = {{24{din[15]}}, din[15:8]};
                    end
                    2'b10 : begin
                        dout = {{24{din[23]}}, din[23:16]};
                    end
                    2'b11 : begin
                        dout = {{24{din[31]}}, din[31:24]};
                    end
                    endcase
            end
            `MEM_LBU : begin
                case(addr[1:0])
                    2'b00 : begin
                        dout = {{24{1'b0}}, din[7:0]};
                    end
                    2'b01 : begin
                        dout = {{24{1'b0}}, din[15:8]};
                    end
                    2'b10 : begin
                        dout = {{24{1'b0}}, din[23:16]};
                    end
                    2'b11 : begin
                        dout = {{24{1'b0}}, din[31:24]};
                    end
                    endcase
            end
            `MEM_LH : begin
                case(addr[1:0])
                    2'b00 : begin
                        dout = {{16{din[15]}}, din[15:0]};
                    end
                    2'b10 : begin
                        dout = {{16{din[31]}}, din[31:16]};
                    end
                    endcase
            end
            `MEM_LHU : begin
                case(addr[1:0])
                    2'b00 : begin
                        dout = {{16{1'b0}}, din[15:0]};
                    end
                    2'b10 : begin
                        dout = {{16{1'b0}}, din[31:16]};
                    end
                    endcase
            end
            `MEM_LW : begin
                dout = din;
            end
            `MEM_SB : begin
                case(addr[1:0])
                    2'b00 : begin
                        store_control = 4'b0001;
                    end
                    2'b01 : begin
                        store_control = 4'b0010;
                    end
                    2'b10 : begin
                        store_control = 4'b0100;
                    end
                    2'b11 : begin
                        store_control = 4'b1000;
                    end
                    default : begin
                        store_control = 4'b0000;
                    end
                    endcase
            end
            `MEM_SH : begin
                case(addr[1:0])
                    2'b00 : begin
                        store_control = 4'b0011;
                    end
                    2'b10 : begin
                        store_control = 4'b1100;
                    end
                    default : begin
                        store_control = 4'b0000;
                    end
                    endcase
            end
            `MEM_SW : begin
                store_control = 4'b1111;

            end
            default : begin
                
            end
            endcase
    end

endmodule
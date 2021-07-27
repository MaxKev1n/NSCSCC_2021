`include "global_define.vh"
module cp0(
    input clk,
    input reset,
    input [] c0_addr,
    input mtc0_we,
    input wb_except,
    input wb_bd,
    input eret_flush,
    input [31:0] c0_wdata,
    input [5:0] ext_int_in,
    input [4:0] wb_excode,

    output [7:0] o_c0_status_im,
    output o_c0_cause_bd,
    output o_c0_cause_ti,
    output [7:0] o_c0_cause_ip,
    output [4:0] o_c0_cause_excode
);

    reg c0_status_bev;
    reg [7:0] c0_status_im;
    reg c0_status_exl;
    reg c0_status_ie;
    reg c0_cause_bd;
    reg c0_cause_ti;
    reg [7:0] c0_cause_ip;
    reg [4:0] c0_cause_excode;

    wire count_eq_compare;

    always @(posedge clk) begin
        if(reset) begin
            c0_status_bev <= 1'b1;
        end 
    end

    always @(posedge clk) begin
        if(mtc0_we && !wb_except && c0_addr == `CR_STATUS) begin
            c0_status_im <= c0_wdata[15:8];
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_status_exl <= 1'b0;
        end else if(wb_except) begin
            c0_status_exl <= 1'b1;
        end else if(eret_flush) begin
            c0_status_exl <= 1'b0;
        end else if(mtc0_we && !wb_except && c0_addr == `CR_STATUS) begin
            c0_status_exl <= c0_wdata[1];
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_status_ie <= 1'b0;
        end else if(mtc0_we && !wb_except && c0_addr == `CR_STATUS) begin
            c0_status_ie <= c0_wdata[0];
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_cause_bd <= 1'b0;
        end else if(wb_except && !c0_status_exl) begin
            c0_cause_bd <= wb_bd;
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_cause_ti <= 1'b0;
        end else if(mtc0_we && !wb_except && c0_addr == `CR_COMPARE) begin
            c0_cause_ti <= 1'b0;
        end if(count_eq_compare) begin
            c0_cause_ti <= 1'b1;
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_cause_ip[7:2] <= 6'b0;
        end else begin
            c0_cause_ip[7] <= ext_int_in[5] | c0_cause_ti;
            c0_cause_ip[6:2] <= ext_int_in[4:0]; 
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_cause_ip[1:0] <= 2'b0;
        end else if(mtc0_we && !wb_except && c0_addr == `CR_CAUSE) begin
            c0_cause_ip[1:0] <= c0_wdata[9:8];
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_cause_excode <= 5'b0;
        end else if(wb_except) begin
            c0_cause_excode <= wb_excode;
        end
    end

    assign o_c0_status_im = c0_status_im;
    assign o_c0_cause_bd = c0_cause_bd;
    assign o_c0_cause_ti = c0_cause_ti;
    assign o_c0_cause_ip = c0_cause_ip;
    assign o_c0_cause_excode = c0_cause_excode;

    assign count_eq_compare = 
endmodule
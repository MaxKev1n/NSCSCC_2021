`include "global_define.vh"
module cp0(
    input clk,
    input reset,
    input [4:0] c0_addr,
    input mtc0_we,
    input wb_except,
    input wb_bd,
    input eret_flush,
    input [31:0] c0_wdata,
    input [5:0] ext_int_in,
    input [4:0] wb_excode,
    input [31:0] wb_pc,
    input [31:0] wb_badvaddr,
    input [4:0] addr,

    output [31:0] data
);

    reg c0_status_bev;
    reg [7:0] c0_status_im;
    reg c0_status_exl;
    reg c0_status_ie;
    reg c0_cause_bd;
    reg c0_cause_ti;
    reg [7:0] c0_cause_ip;
    reg [4:0] c0_cause_excode;
    reg [31:0] c0_epc;
    reg [31:0] c0_badvaddr;
    reg [31:0] c0_count;
    reg tick;
    reg [31:0] c0_compare;

    wire count_eq_compare;

    always @(posedge clk) begin
        if(reset) begin
            c0_status_bev <= 1'b1;
        end 
    end

    always @(posedge clk) begin
        if(mtc0_we && !wb_except && c0_addr == `CR_STATUS ) begin
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

    always @(posedge clk) begin
        if(wb_except && !c0_status_exl) begin
            c0_epc <= wb_bd ? wb_pc - 31'h4 : wb_pc;
        end else if(mtc0_we && !wb_except && c0_addr == `CR_EPC) begin
            c0_epc <= c0_wdata;
        end
    end

    always @(posedge clk) begin
       if(wb_except && (wb_excode == 5'h04 || wb_excode == 5'h05)) begin
           c0_badvaddr <= wb_badvaddr;
       end 
    end

    always @(posedge clk) begin
        if(reset) begin
            tick <= 1'b0;
        end else begin
            tick <= ~tick;
        end
        if(mtc0_we && !wb_except && c0_addr ==`CR_COUNT) begin
            c0_count <= c0_wdata;
        end else if(tick) begin
            c0_count <= c0_count + 1'b1;
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            c0_compare <= 31'd0;
        end else if(mtc0_we && !wb_except && c0_addr == `CR_COMPARE) begin
            c0_compare <= c0_wdata;
        end
    end

   assign data = addr == `CR_COUNT    ? c0_count : (
                 addr == `CR_COMPARE  ? c0_compare : (
                 addr == `CR_STATUS   ? {9'd0, c0_status_bev, 6'd0, c0_status_im, 6'd0, c0_status_exl, c0_status_ie} : (
                 addr == `CR_CAUSE    ? {c0_cause_bd, c0_cause_ti, 14'd0, c0_cause_ip, 1'b0, c0_cause_excode, 2'b00} : (
                 addr == `CR_EPC      ? c0_epc : (
                 addr == `CR_BADVADDR ? c0_badvaddr : `ZeroWord  
                 )    
                 )    
                 )
                 )
   );

    assign count_eq_compare = c0_count == c0_compare ? 1'b1 : 1'b0;
endmodule
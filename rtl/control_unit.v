module control_unit(
    input [31:0] inst,
    input [31:0] pc,
    input rs_eq_rt,
    input [4:0] exe_reg,
    input [4:0] mem_reg,
    input wb_write_regfile,
    input exe_mem_to_regfile,
    input mem_mem_to_regfile,
    input exe_write_regfile,
    input mem_write_regfile,

    output write_mem,
    output write_regfile,
    output mem_to_regfile,
    output jal,
    output aluimm,
    output shift,
    output sext,
    output rd_or_rt,
    output fwda,
    output fwdb,
    output [31:0] bpc,
    output [31:0] jpc,
    output [1:0] pcsource,
    output [14:0] ALUControl,
    output [7:0] mem_control
);

    wire [5:0] op = inst[31:26];
    wire [4:0] rs = inst[25:21];
    wire [4:0] rt = inst[20:16];
    wire [5:0] func = inst[5:0];

    wire inst_add;
    wire inst_addi;
    wire inst_addiu;
    wire inst_addu;
    wire inst_clo;
    wire inst_clz;
    wire inst_div;
    wire inst_divu;
    wire inst_madd;
    wire inst_maddu;
    wire inst_msub;
    wire inst_msubu;
    wire inst_mul;
    wire inst_mult;
    wire inst_multu;
    wire inst_slt;
    wire inst_slti;
    wire inst_sltiu;
    wire inst_sltu;
    wire inst_sub;
    wire inst_subu;
    wire inst_beq;
    wire inst_bgez;
    wire inst_bgezal;
    wire inst_bgtz;
    wire inst_blez;
    wire inst_bltz;
    wire inst_bltzal;
    wire inst_bne;
    wire inst_j;
    wire inst_jal;
    wire inst_jalr;
    wire inst_jr;
    wire inst_lb;
    wire inst_lbu;
    wire inst_lh;
    wire inst_lhu;
    wire inst_ll;
    wire inst_lw;
    wire inst_lwl;
    wire inst_lwr;
    wire inst_pref;
    wire inst_sb;
    wire inst_sc;
    wire inst_sh;
    wire inst_sw;
    wire inst_swl;
    wire inst_swr;
    wire inst_sync;
    wire inst_and;
    wire inst_andi;
    wire inst_lui;
    wire inst_nor;
    wire inst_or;
    wire inst_ori;
    wire inst_xor;
    wire inst_xori;
    wire inst_mfhi;
    wire inst_mflo;
    wire inst_movf;
    wire inst_movn;
    wire inst_movt;
    wire inst_movz;
    wire inst_mthi;
    wire inst_mtlo;
    wire inst_sll;
    wire inst_sllv;
    wire inst_sra;
    wire inst_srav;
    wire inst_srl;
    wire inst_srlv;
    wire inst_break;
    wire inst_syscall;
    wire inst_teq;
    wire inst_teqi;
    wire inst_tge;
    wire inst_tgei;
    wire inst_tgeiu;
    wire inst_tgeu;
    wire inst_tlt;
    wire inst_tlti;
    wire inst_tltiu;
    wire inst_tltu;
    wire inst_tne;
    wire inst_tnei;
    wire inst_beql;
    wire inst_bgezall;
    wire inst_bgtzl;
    wire inst_blezl;
    wire inst_bltzall;
    wire inst_bltzl;
    wire inst_bnel;
    wire inst_cache;
    wire inst_eret;
    wire inst_mfc0;
    wire inst_mtc0;
    wire inst_tlbp;
    wire inst_tlbr;
    wire inst_tlbwi;
    wire inst_tlbwr;
    wire inst_wait;

    assign inst_add = (op == 6'd0) & (func == 6'd32);
    assign inst_addi = (op == 6'd8);
    assign inst_addiu = (op == 6'd9);
    assign inst_addu = (op == 6'd0) & (func == 6'd33);
    assign inst_clo = (op == 6'd28) & (func == 6'd33);
    assign inst_clz = (op == 6'd28) & (func == 6'd32);
    assign inst_div = (op == 6'd0) & (func == 6'd26);
    assign inst_divu = (op == 6'd0) & (func == 6'd27);
    assign inst_madd = (op == 6'd28) & (func == 6'd0);
    assign inst_maddu = (op == 6'd28) & (func == 6'd1);
    assign inst_msub = (op == 6'd28) & (func == 6'd4);
    assign inst_msubu = (op == 6'd28) & (func == 6'd5);
    assign inst_mul = (op == 6'd28) & (func == 6'd2);
    assign inst_mult = (op == 6'd0) & (func == 6'd24);
    assign inst_multu = (op == 6'd0) & (func == 6'd25);
    assign inst_slt = (op == 6'd0) & (func == 6'd42);
    assign inst_slti = (op == 6'd10);
    assign inst_sltiu = (op == 6'd11);
    assign inst_sltu = (op == 6'd0) & (func == 6'd43);
    assign inst_sub = (op == 6'd0) & (func == 6'd34);
    assign inst_subu = (op ==6'd0) & (func == 6'd35);
    assign inst_beq = (op == 6'd4);
    assign inst_bgez = (op == 6'd1) & (rt == 5'd1);
    assign inst_bgezal = (op == 6'd1) & (rt == 5'd17);
    assign inst_bgtz = (op == 6'd7) & (rt == 5'd0);
    assign inst_blez = (op == 6'd6) & (rt == 5'd0);
    assign inst_bltz = (op == 6'd1) & (rt == 5'd0);
    assign inst_bltzal = (op == 6'd1) & (rt == 5'd16);
    assign inst_bne = (op == 6'd5);
    assign inst_j = (op == 6'd2);
    assign inst_jal = (op == 6'd3);
    assign inst_jalr = (op == 6'd0) & (func == 6'd9);
    assign inst_jr = (op == 6'd0) & (func == 6'd8);
    assign inst_lb = (op == 6'd32);
    assign inst_lbu = (op == 6'd36);
    assign inst_lh = (op == 6'd33);
    assign inst_lhu = (op == 6'd37);
    assign inst_ll = (op == 6'd48);
    assign inst_lw = (op == 6'd35);
    assign inst_lwl = (op == 6'd34);
    assign inst_lwr = (op == 6'd38);
    assign inst_pref = (op == 6'd51);
    assign inst_sb = (op == 6'd40);
    assign inst_sc = (op == 6'd56);
    assign inst_sh = (op == 6'd41);
    assign inst_sw = (op == 6'd43);
    assign inst_swl = (op == 6'd42);
    assign inst_swr = (op == 6'd46);
    assign inst_sync = (op == 6'd0) & (func == 6'd15);
    assign inst_and = (op == 6'd0) & (func == 6'd36);
    assign inst_andi = (op == 6'd12);
    assign inst_lui = (op == 6'd15);
    assign inst_nor = (op == 6'd0) & (func == 6'd39);
    assign inst_or = (op == 6'd0) & (func == 6'd37);
    assign inst_ori = (op == 6'd13);
    assign inst_xor = (op == 6'd0) & (func == 6'd38);
    assign inst_xori = (op == 6'd14);
    assign inst_mfhi = (op == 6'd0) & (func == 6'd16);
    assign inst_mflo = (op == 6'd0) & (func == 6'd18);
    assign inst_movf = (op == 6'd0) & (func == 6'd1) & (inst[17:16] == 2'b0);
    assign inst_movn = (op == 6'd0) & (func == 6'd11);
    assign inst_movt = (op == 6'd0) & (func == 6'd1) & (inst[17:16] == 2'b1);
    assign inst_movz = (op == 6'd0) & (func == 6'd10);
    assign inst_mthi = (op == 6'd0) & (func == 6'd17);
    assign inst_mtlo = (op == 6'd0) & (func == 6'd18);
    assign inst_sll = (op == 6'd0) & (func == 6'd0);//
    assign inst_sllv = (op == 6'd0) & (func == 6'd4);
    assign inst_sra = (op == 6'd0) & (func == 6'd3);
    assign inst_srav = (op == 6'd0) & (func == 6'd7);
    assign inst_srl = (op == 6'd0) & (func == 6'd6);
    assign inst_srlv = (op == 6'd0) & (func == 6'd6);//
    assign inst_break = (op == 6'd0) & (func == 6'd13);
    assign inst_syscall = (op == 6'd0) & (func == 6'd12);
    assign inst_teq = (op == 6'd0) & (func == 6'd52);
    assign inst_teqi = (op == 6'd1) & (rt == 5'd12);
    assign inst_tge = (op == 6'd0) & (func == 6'd48);
    assign inst_tgei = (op == 6'd1) & (rt == 5'd8);
    assign inst_tgeiu = (op == 6'd10) & (rt == 5'd9);
    assign inst_tgeu = (op == 6'd0) & (func == 6'd49);
    assign inst_tlt = (op == 6'd0) & (func == 6'd50);
    assign inst_tlti = (op == 6'd1) & (rt == 5'd10);
    assign inst_tltiu = (op == 6'd1) & (rt == 5'd11);
    assign inst_tltu = (op == 6'd0) & (func == 6'd51);
    assign inst_tne = (op == 6'd0) & (func == 6'd64);
    assign inst_tnei = (op == 6'd1) & (rt == 5'd18);
    assign inst_beql = (op == 6'd20);
    assign inst_bgezall = (op == 6'd1) & (rt == 5'd19);
    assign inst_bgtzl = (op == 6'd23) & (rt == 5'd0);
    assign inst_blezl = (op == 6'd22) & (rt == 5'd0);
    assign inst_bltzall = (op == 6'd1) & (rt == 5'd18);
    assign inst_bltzl = (op == 6'd1) & (rt == 5'd2);
    assign inst_bnel = (op == 6'd21);
    assign inst_cache = (op == 6'd47);
    assign inst_eret = (op == 6'd16) & (func == 6'd24);
    assign inst_mfc0 = (op == 6'd16) & (rs == 5'd0) & (func == 6'd0);
    assign inst_mtc0 = (op == 6'd16) & (rs == 5'd4) & (func == 6'd0);
    assign inst_tlbp = (op == 6'd16) & (rs == 5'd16) & (func == 6'd8);
    assign inst_tlbr = (op == 6'd16) & (rs == 5'd16) & (func == 6'd1);
    assign inst_tlbwi = (op == 6'd16) & (rs == 5'd16) & (func == 6'd2);
    assign inst_tlbwr = (op == 6'd16) ^ (rs == 5'd16) & (func == 6'd6);
    //assign inst_wait = 

    wire ADDU_inst = inst_addu | inst_addiu | inst_lw | inst_sw;
    wire ADD_inst = inst_add | inst_addi;
    wire SUB_inst = inst_sub;
    wire SUBU_inst = inst_subu;
    wire AND_inst = inst_and | inst_andi;
    wire OR_inst = inst_or | inst_ori;
    wire XOR_inst = inst_xor | inst_xori;
    wire NOR_inst = inst_nor;
    wire SLT_inst = inst_slt | inst_slti;
    wire SLTU_inst = inst_sltu | inst_sltiu;
    wire SLL_inst = inst_sll | inst_sllv;
    wire SRL_inst = inst_srl | inst_srlv;
    wire SRA_inst = inst_sra | inst_srav;
    wire LUI_inst = inst_lui;
    wire JUMP_BRANCH_inst = inst_jr | inst_beq | inst_bne | inst_j | inst_jal;

    //
    assign R_type = inst_add | inst_addu | inst_sub | inst_subu | inst_or | inst_xor | inst_nor | inst_slt | inst_sltu | inst_sll | inst_srl | inst_sra | inst_sllv | inst_srlv |
                    inst_srav | inst_jr;
    assign I_type = inst_addi | inst_addiu | inst_andi | inst_ori | inst_xori | inst_lui | inst_lw | inst_sw | inst_beq | inst_bne | inst_slti | inst_sltiu;
    assign J_type = inst_j | inst_jal;

    assign ALUControl = {
        ADDU_inst,
        ADD_inst,
        SUB_inst,
        SUBU_inst,
        AND_inst,
        OR_inst,
        XOR_inst,
        NOR_inst,
        SLT_inst,
        SLTU_inst,
        SLL_inst,
        SRL_inst,
        SRA_inst,
        LUI_inst,
        JUMP_BRANCH_inst
    };

    assign write_mem = inst_sw;
    assign write_regfile = inst_add | inst_addu | inst_sub | inst_subu | inst_add | inst_or | inst_xor |
                           inst_nor | inst_slt | inst_sltu | inst_sll | inst_srl | inst_sra | inst_sllv |
                           inst_srlv | inst_srav | inst_addi | inst_addiu | inst_andi | inst_ori | inst_xori |
                           inst_lui | inst_slti | inst_sltiu | inst_jal;
    assign mem_to_regfile = inst_lw;
    assign jal = inst_jal;
    assign aluimm = inst_addi | inst_addiu | inst_andi | inst_ori | inst_xori | inst_lui | inst_lw | inst_sw |
                    inst_slti | inst_sltiu;
    assign shift = inst_sll | inst_srl | inst_sra | inst_sllv | inst_srlv | inst_srav;
    assign sext = inst_addi | inst_lw | inst_sw | inst_beq | inst_bne | inst_slti | inst_sltiu; //1'b1 sign : 1'b0 zero
    assign rd_or_rt = inst_add | inst_addu | inst_sub | inst_subu | inst_and | inst_or | inst_xor | inst_nor |
                      inst_slt | inst_sltu | inst_sll | inst_srl | inst_sra | inst_sllv | inst_srlv | inst_srav; //1'b1 rd : 1'b0 rt

    wire is_branch = rs_eq_rt & inst_beq ? 1'b1 : (!rs_eq_rt & inst_bne ? 1'b1 : 1'b0);
    assign bpc = pc + {16{inst[15], inst[15:0]}};
    wire is_jump = inst_jal | inst_j;
    assign jpc = {pc[31:28], inst[25:0], 2'b00}; //?
    wire is_jump_jr = inst_jr;

    assign pcsource = is_branch ? 2'b11 : (is_jump ? 2'b10 : (is_jump_jr ? 2'b01 : 2'b00));
    assign mem_control = {
        inst_lb,
        inst_lbu,
        inst_lh,
        inst_lhu,
        inst_lw,
        inst_sb,
        inst_sh,
        inst_sw
    };

    always @(*) begin
        fwda = 2'b00;
        if(exe_write_regfile && (exe_reg != 5'b00000) && !exe_mem_to_regfile && (exe_reg == rs)) begin
            fwda = 2'b01;
        end else begin
            if(mem_write_regfile && (mem_reg != 5'b00000) && !mem_mem_to_regfile && (mem_reg == rs)) begin
                fwda = 2'b10;
            end else if(mem_write_regfile && (mem_reg != 5'b00000) && mem_mem_to_regfile && (mem_reg == rs)) begin
                fwda = 2'b11;
            end
        end
    end

    always @(*) begin
        fwdb = 2'b00;
        if(exe_write_regfile && (exe_reg != 5'b00000) && !exe_mem_to_regfile && (exe_reg == rt)) begin
            fwdb = 2'b01;
        end else begin
            if(mem_write_regfile && (mem_reg != 5'b00000) && !mem_mem_to_regfile && (mem_reg == rt)) begin
                fwdb = 2'b10;
            end else if(mem_write_regfile && (mem_reg != 5'b00000) && mem_mem_to_regfile && (mem_reg == rt)) begin
                fwdb = 2'b11;
            end
        end
    end
endmodule
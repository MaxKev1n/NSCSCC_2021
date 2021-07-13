module control_unit(
    input [31:0] inst,
    input rs_eq_rt,
    input [4:0] exe_reg,
    input [4:0] mem_reg,

    output write_men,
    output write_regfile,
    output jal,
    output aluimm,
    output shift,
    output sext,
    output rd_or_rt,
    output fwda,
    output fwdb
);

    wire op[5:0] = inst[31:26];
    wire rs[4:0] = inst[25:21];
    wire rt[4:0] = inst[20:16];
    wire func[5:0] = inst[5:0];

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
    assign inst_jalr = (op == 6'd0) & (func = 6'd9);
    assign inst_jr = (op == 6'd0) & (func = 6'd8);
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
    assign inst_tgeiu = (op == 6'd10 & (rt == 5'd9);
    assign inst_tgeu = (op == 6'd0) & (func == 6'd49);
    assign inst_tlt = (op == 6'd0) & (func == 6'd50);
    assign inst_tlti = (op == 6'd1) & (rt == 5'd10);
    assign inst_tltiu = (op == 6'd1) & (rt == 5'd11);
    assign inst_tltu = (op == 6'd0) & (func == 6'd51);
    assign inst_tne = (op == 6'd0) & (func == 6'd64);
    assign inst_tnei == (op == 6'd1) & (rt == 5'd18);
    assign inst_beql == (op == 6'd20);
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
endmodule
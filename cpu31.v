`timescale 1ns / 1ps

module cpu31(clk_in,reset,instr,pc_out,dmem_out,dmem_addr,dmem_data,dmem_we);
    input clk_in;
    input reset;
    //input [31:0] instr;
    input [31:0] instr;
    output reg [31:0] pc_out;
    input [31:0]dmem_out;
    output [31:0] dmem_addr;
    output [31:0] dmem_data;
    //output [31:0] imem_addr;
    output dmem_we;
    
    //====================Control_Unit==================================
    //module Control_Unit(op,func,rs,z,nega,wmem,wreg,regrt,m5reg,aluc,aluc_a,aluc_b,pcsource,sext,loadkind,
    //     storekind,m2cal,whilo,c1,c2,exception,eret,mfc0,mtc0);
    wire wmem;
    wire wreg;
    wire regrt;
    wire [2:0]m5reg;
    wire [4:0]aluc;
    wire aluc_a;  
    wire aluc_b; 
    wire select_jal;
    wire [1:0]pcsource;
    wire sext;  
    wire [1:0]loadkind;
    wire [1:0]storekind;
    wire [1:0]m2cal;
    wire wlohi;
    wire c1;
    wire c2;
    wire [1:0]c3;
    wire exception;
    wire eret;
    wire mfc0;
    wire mtc0;
    wire bgez;
    //=======================ALU==========================================
    //module alu(a,b,aluc,r,zero,carry,negative,overflow);
    wire zero;
    //wire carry;
    //wire overflow;
    wire negative;
    wire [31:0]r;
    //===========================MUDIV=====================================
    //module multidiv(clk,reset,a,b,m2cal,low,high);
    wire [31:0]low;
    wire [31:0]high;
    //=======================HILO=========================================
    //module HILO(clk,reset,wlohi,c3,in_lo,in_hi,out_lo,out_hi);
    wire [31:0]lo_out;
    wire [31:0]hi_out;
    //=======================InstMem=======================================
    //module InstMEM(pc,instr);
    //wire [31:0] instr;
    //R-type
    wire [5:0] op;
    assign op=instr[31:26];
    wire [4:0] rs;
    assign rs=instr[25:21];
    wire [4:0] rt_tmp;
    assign rt_tmp=instr[20:16];
    wire [4:0] rt;
    assign rt=(bgez==1)?(rt_tmp-1'b1):rt_tmp;
    wire [4:0] rd;
    assign rd=instr[15:11];
    wire [15:0] shamt;
    assign shamt[15:5]=11'b00000000000;
    assign shamt[5:0]=instr[10:6];
    wire [31:0] shamt_ext;
    signZeroExtend ext_shamt(shamt,1'b0,shamt_ext);
    wire [5:0] func;
    assign func=instr[5:0];
    //I-type
    wire [15:0] immediate;
    assign immediate=instr[15:0];
    wire [31:0] immext;
    signZeroExtend ext_imm(immediate,sext,immext);
    //J-type
    wire [25:0] address;
    assign address=instr[25:0];
   //======================Regfiles====================================
   //module Regfiles(clk,rst,we,raddr1,raddr2,waddr,wdata,rdata1,rdata2);
    wire [31:0]a_rdata1;
    wire [31:0]b_rdata2;
    //=======================DMEM=======================================
    //module DataMEM(clk,InAddr,InData,we,DataOut);
    assign dmem_we = wmem;
    assign dmem_addr = r;
    wire [31:0]store_data;
    mux_bit store(b_rdata2,storekind,sext,store_data);
    assign dmem_data = store_data;
    //=======================CP0=========================================
    //module CP0(clk,rst,mfc0,mtc0,pc,addr,data,exception,eret,cause,rdata,status,exc_addr);
    wire [4:0] cause;
    wire [31:0]rdata;
    wire [31:0]status;
    wire [31:0]exc_addr;
    //=======================PC===========================================
    //module pc(clk,rst,pc_in,pc_out);
    //wire [31:0] pc_out;
    wire [31:0] npc_0;                            //pc+1;pc+4
    assign npc_0 = pc_out +32'd4 ;
    //wire [31:0] npc_1;                         //BranchAddr;
    //assign npc_1= pc_out + 4+ (immediate<<2);   //beq,bne
    //wire [31:0] npc_2;
    //assign npc_2= a_rdata1;                     //jr
    //wire [31:0] npc_3;
    //assign npc_3= {npc_0[31:28],address,2'b00};  //j jal
    //wire [31:0] npc_mux;
    //mux4 next_pc(npc_0,npc_1,npc_2,npc_3,pcsource,npc_mux);
    //module pc(clk,rst,pc_in,pc_out);
    //pc pc_(clk_in,reset,npc_mux,pc_out);
    
    initial begin
        pc_out=32'h00400000;
    end
    
    always @ (posedge clk_in or posedge reset) begin
        if(reset) pc_out<=32'h00400000;
        else if(exception)
            pc_out<=exc_addr+32'd4;
        else begin            
        case(pcsource)
        2'b00:pc_out<=pc_out +32'd4;
        2'b01:pc_out<=pc_out + 32'd4+ (immext<<2);
        2'b10:pc_out<=a_rdata1;
        2'b11:pc_out<={npc_0[31:28],address,2'b00};
        endcase
    end
    end
    //=====================Other=======================================
    //shamt or rs(add) 选择块
    wire [31:0] mux_shamt;       //在rdata1和shamt中进行选择
    mux_2 mux_shift_unit(a_rdata1,shamt_ext,aluc_a,mux_shamt);
    
    //选择有无立即数的操作块
    wire [31:0] mux_immext;    //在b_rdata2和immext中进行选择
    mux_2 mux_immediate_unit(b_rdata2,immext,aluc_b,mux_immext); 
     
    wire [31:0] dmem_out_s; //读入dmem数据的大小
    mux_bit load (dmem_out,loadkind,sext,dmem_out_s);
    wire [31:0] lohi;
    mux_2 mux_reg_hilo(lo_out,hi_out,c2,lohi);
    //选择是r还是dmem_out还是pc+4还是lohi还是exc_addr读入Reg的wdata块 
    wire [31:0] mux_m5reg;    //在r和datamem(lw)中进行选择
    mux5_1 mux_m5reg_unit(r,dmem_out_s,npc_0,lohi,rdata,m5reg,mux_m5reg);
    
    //选择I-format(rd,1) or R-format(rt,0)块
    wire [4:0] mux_regrt;
    mux_2_5bits mux_regrt_unit(rd,rt,regrt,mux_regrt);
    
    //选择wdata中是读入mux_r2reg还是pc+4
    wire [31:0] mux_jal;
    mux_2 mux_jal_unit(mux_m5reg,npc_0,select_jal,mux_jal);
    
    //选择在waddr输入regrt还是$31
    wire [4:0] wn;
    assign wn = mux_regrt | {5{select_jal}};  //jal=1,5{jal}=111111->$31  $31<-- pc+4
    
    //module Regfiles(clk,rst,we,raddr1,raddr2,waddr,wdata,rdata1,rdata2);
    Regfiles cpu_ref(clk_in,reset,wreg,rs,rt,wn,mux_jal,a_rdata1,b_rdata2);
    
    //module Control_Unit(op,func,rs,z,nega,wmem,wreg,regrt,m5reg,aluc,aluc_a,aluc_b,jal,pcsource,sext,loadkind,
    //     storekind,m2cal,wlohi,c1,c2,exception,eret,mfc0,mtc0,cause,c3);
    Control_Unit control_unit_(op,func,rs,zero,negative,wmem,wreg,regrt,m5reg,aluc,aluc_a,aluc_b,select_jal,pcsource,sext,loadkind,
    storekind,m2cal,wlohi,c1,c2,exception,eret,mfc0,mtc0,cause,c3,bgez);
    
   //module alu(a,b,aluc,r,negative);
    alu alu_(mux_shamt,mux_immext,aluc,r,zero,negative);
    
    //module HILO(clk,reset,wlohi,c3,in_lo,in_hi,out_lo,out_hi);
     wire [31:0] in_lo;
     wire [31:0] in_hi;
     mux_2 mux_lo(a_rdata1,low,c1,in_lo);
     mux_2 mux_hi(a_rdata1,high,c1,in_hi);
     HILO hilo(clk_in,reset,wlohi,c3,in_lo,in_hi,lo_out,hi_out);
    
     //module multidiv(clk,reset,a,b,m2cal,lo,hi);
     multidiv mul_div(a_rdata1,b_rdata2,m2cal,low,high);
    
     //module CP0(clk,rst,mfc0,mtc0,pc,addr,data,exception,eret,cause,rdata,status,exc_addr);
     CP0 cp0(clk_in,reset,mfc0,mtc0,pc_out,rd,b_rdata2,exception,eret,cause,rdata,status,exc_addr);
    
endmodule

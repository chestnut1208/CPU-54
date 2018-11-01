`timescale 1ns / 1ps

module Control_Unit(op,func,rs,z,nega,wmem,wreg,regrt,m5reg,aluc,aluc_a,aluc_b,jal,pcsource,sext,loadkind,
     storekind,m2cal,wlohi,c1,c2,exception,eret,mfc0,mtc0,cause,c3,bgez);
    input [5:0] op;
    input [5:0] func;
	input [4:0] rs;
    input z;  //zero
    input nega;   //negative
    output wmem;  //写使能：1写入数据存储器Datamem 0:不写
    output wreg;  //写使能，1写入寄存堆regfile 0：不写
    output regrt; //写入reg 1选择rt，0选择rd
    output [2:0] m5reg; //多路器选择信号，1选择从寄存器中读出的数据(lw)，0选择alu的运算结果
    //2选择pc+4，3选择lohi，4选择exc_addr
    output [4:0] aluc; //计算处理
    output aluc_a; //1选择寄存器移位位数shamt，0选择寄存器堆regfile的数据rs
    output aluc_b; //1选择扩展后的立即数immediate，0选择寄存器堆的数据rd
    output jal;
    output [1:0] pcsource; //00：PC+4，10：选择转移地址jr，01：选择寄存器地址bne，beq 11：选择跳转地址j,jal
    //output call; //1：选择PC+4，0：选择alu或寄存器堆的数据
    output sext; //1：符号扩展sign-extend，0：0扩展zero-extend
    output [1:0] loadkind; //选择存储进DMEM的rt字节，00:word,01:half-word 10:byte
    output [1:0] storekind;
    output [1:0] m2cal; //选择乘除器的操作类型 00:mult 01:undiv 10:div
    output wlohi;
    output c1; //rs or lo/hi
    output c2; //lo or hi
    output exception;
    output eret;
    output mfc0;
    output mtc0;
    output [4:0] cause;
    output [1:0] c3;
    output bgez;
    
    //R-type
    wire r_type=(op==6'b000000)?1:0;
    wire add   =r_type&  func[5] &(~func[4])&(~func[3])&(~func[2])&(~func[1])&(~func[0]); //100000
    wire addu  =r_type&  func[5] &(~func[4])&(~func[3])&(~func[2])&(~func[1])&  func[0];  //100001
    wire sub   =r_type&  func[5] &(~func[4])&(~func[3])&(~func[2])&  func[1] &(~func[0]); //100010
    wire subu  =r_type&  func[5] &(~func[4])&(~func[3])&(~func[2])&  func[1] &  func[0];  //100011
    wire and_r =r_type&  func[5] &(~func[4])&(~func[3])&  func[2] &(~func[1])&(~func[0]); //100100
    wire or_r  =r_type&  func[5] &(~func[4])&(~func[3])&  func[2] &(~func[1])&  func[0];  //100101
    wire xor_r =r_type&  func[5] &(~func[4])&(~func[3])&  func[2] &  func[1] &(~func[0]); //100110
    wire nor_r =r_type&  func[5] &(~func[4])&(~func[3])&  func[2] &  func[1] &  func[0];  //100111
    wire slt   =r_type&  func[5] &(~func[4])&  func[3] &(~func[2])&  func[1] &(~func[0]); //101010
    wire sltu  =r_type&  func[5] &(~func[4])&  func[3] &(~func[2])&  func[1] &  func[0];  //101011
    wire sll   =r_type&(~func[5])&(~func[4])&(~func[3])&(~func[2])&(~func[1])&(~func[0]); //000000
    wire srl   =r_type&(~func[5])&(~func[4])&(~func[3])&(~func[2])&  func[1] &(~func[0]); //000010
    wire sra   =r_type&(~func[5])&(~func[4])&(~func[3])&(~func[2])&  func[1] &  func[0];  //000011
    wire sllv  =r_type&(~func[5])&(~func[4])&(~func[3])&  func[2] &(~func[1])&(~func[0]); //000100
    wire srlv  =r_type&(~func[5])&(~func[4])&(~func[3])&  func[2] &  func[1] &(~func[0]); //000110
    wire srav  =r_type&(~func[5])&(~func[4])&(~func[3])&  func[2] &  func[1] &  func[0];  //000111
    wire jr    =r_type&(~func[5])&(~func[4])&  func[3] &(~func[2])&(~func[1])&(~func[0]); //001000
	//new
	wire jalr  =r_type&(~func[5])&(~func[4])&  func[3] &(~func[2])&(~func[1])&  func[0];  //001001
	wire mfhi  =r_type&(~func[5])&  func[4] &(~func[3])&(~func[2])&(~func[1])&(~func[0]); //010000
	wire mthi  =r_type&(~func[5])&  func[4] &(~func[3])&(~func[2])&(~func[1])&  func[0];  //010001
	wire mflo  =r_type&(~func[5])&  func[4] &(~func[3])&(~func[2])&  func[1] &(~func[0]); //010010
	wire mtlo  =r_type&(~func[5])&  func[4] &(~func[3])&(~func[2])&  func[1] &  func[0];  //010011
	wire div   =r_type&(~func[5])&  func[4] &  func[3] &(~func[2])&  func[1] &(~func[0]); //011010
	wire divu  =r_type&(~func[5])&  func[4] &  func[3] &(~func[2])&  func[1] &  func[0];  //011011
	wire multu =r_type&(~func[5])&  func[4] &  func[3] &(~func[2])&(~func[1])&  func[0];  //011001
	wire i_break=r_type&(~func[5])&(~func[4])&  func[3] &  func[2] &(~func[1])&  func[0]; //001101
	wire teq   =r_type&  func[5] &  func[4] &(~func[3])&  func[2] &(~func[1])&(~func[0]); //110100
	wire syscall=r_type&(~func[5])&(~func[4])&  func[3] &  func[2] &(~func[1])&(~func[0]); //001100
    
    //I-type
    wire addi  =(~op[5])&(~op[4])&  op[3] &(~op[2])&(~op[1])&(~op[0]); //001000
    wire addiu =(~op[5])&(~op[4])&  op[3] &(~op[2])&(~op[1])&  op[0];  //001001
    wire andi  =(~op[5])&(~op[4])&  op[3] &  op[2] &(~op[1])&(~op[0]); //001100
    wire ori   =(~op[5])&(~op[4])&  op[3] &  op[2] &(~op[1])&  op[0];  //001101
    wire xori  =(~op[5])&(~op[4])&  op[3] &  op[2] &  op[1] &(~op[0]); //001110
    wire lw    =  op[5] &(~op[4])&(~op[3])&(~op[2])&  op[1] &  op[0];  //100011
    wire sw    =  op[5] &(~op[4])&  op[3] &(~op[2])&  op[1] &  op[0];  //101011
    wire beq   =(~op[5])&(~op[4])&(~op[3])&  op[2] &(~op[1])&(~op[0]); //000100
    wire bne   =(~op[5])&(~op[4])&(~op[3])&  op[2] &(~op[1])&  op[0];  //000101
    wire slti  =(~op[5])&(~op[4])&  op[3] &(~op[2])&  op[1] &(~op[0]); //001010
    wire sltiu =(~op[5])&(~op[4])&  op[3] &(~op[2])&  op[1] &  op[0];  //001011
    wire lui   =(~op[5])&(~op[4])&  op[3] &  op[2] &  op[1] &  op[0];  //001111
	//new
	wire lb    =  op[5] &(~op[4])&(~op[3])&(~op[2])&(~op[1])&(~op[0]); //100000
	wire lbu   =  op[5] &(~op[4])&(~op[3])&  op[2] &(~op[1])&(~op[0]); //100100
	wire lh    =  op[5] &(~op[4])&(~op[3])&(~op[2])&(~op[1])&  op[0];  //100001
	wire lhu   =  op[5] &(~op[4])&(~op[3])&  op[2] &(~op[1])&  op[0];  //100101
	wire sb    =  op[5] &(~op[4])&  op[3] &(~op[2])&(~op[1])&(~op[0]); //101000
	wire sh    =  op[5] &(~op[4])&  op[3] &(~op[2])&(~op[1])&  op[0];  //101001
	wire bgez  =(~op[5])&(~op[4])&(~op[3])&(~op[2])&(~op[1])&  op[0];  //000001
    
    //J-type
    wire j     =(~op[5])&(~op[4])&(~op[3])&(~op[2])&  op[1] &(~op[0]); //000010
    wire jal   =(~op[5])&(~op[4])&(~op[3])&(~op[2])&  op[1] &  op[0];  //000011 
	
	wire op_2  =(op==6'b010000)?1:0;
	wire mfc0  =op_2&(~rs[4])&(~rs[3])&(~rs[2])&(~rs[1])&(~rs[0]); //00000
	wire mtc0  =op_2&(~rs[4])&(~rs[3])&  rs[2] &(~rs[1])&(~rs[0]); //00100
	wire eret  =op_2&  rs[4] &(~rs[3])&(~rs[2])&(~rs[1])&(~rs[0]); //10000
	
	wire op_3  =(op==6'b011100)?1:0;
	wire clz   =op_3&  func[5] &(~func[4])&(~func[3])&(~func[2])&(~func[1])&(~func[0]); //100000
	wire mul   =op_3&(~func[5])&(~func[4])&(~func[3])&(~func[2])&  func[1] &(~func[0]); //000010
    
    assign exception=eret | i_break | syscall | teq&&z;
    //写使能regfile
    assign wreg= add | addu | sub | subu | and_r
                | or_r | xor_r | nor_r | slt | sltu
                | sll | srl | sra | sllv | srlv | srav
                | addi | addiu | andi | ori | xori | lw
                | slti | sltiu | lui | jal | clz | jalr 
                | lb | lbu | lh | lhu | mflo | mul | mfc0 | mfhi; 
                
    //写使能datamem
    assign wmem= sw | sb | sh;
    
    //rd or rt ? regrt=1:rt
    assign regrt = addi | addiu | andi | ori | xori | lw |
                   slti | sltiu | lui | lb | lbu | lh | lhu 
                   | mfc0;
                  
    //m5reg=1:write address from DataMEM
    assign m5reg[0]= lw | lb | lbu | lh | lhu | mflo | mfhi;
    assign m5reg[1]= jal | jalr | mflo | mfhi;
    assign m5reg[2]= mfc0;
    
    assign aluc_a= sll | srl | sra; 
    
    assign aluc_b= addi | addiu | andi | ori | xori | lw | sw |
                    sltiu | slti | lui | lb | lbu | lh | lhu |
                    sb | sh; 
                  
    assign sext= addi | lw | sw | beq | bne | slti | addiu | sltiu
                 | lb | lh;
    
    assign aluc[4]= clz | mul;
    
    assign aluc[3]= slt | sltu | sll | srl | sra | sllv | srlv | srav |
                   slti | sltiu | lui | beq | bne;
                   
    assign aluc[2]= and_r | or_r | xor_r | nor_r | sll | srl | sra | sllv
                   | srlv | srav | andi | ori | xori | mul;
                   
    assign aluc[1] = add | sub | xor_r | nor_r | slt | sltu | sll | sllv |
                   | addi | xori | lw | sw | beq | bne | slti | sltiu
                   | lb | lbu | lh | lhu | sb | sh | teq | bgez;
                   
    assign aluc[0] = sub | subu | or_r | nor_r | slt | srl | srlv | ori | 
                   | slti | beq | bne | teq | bgez;
                   
    assign pcsource[0]= z&beq | ~z&bne | j | jal | (~nega)&bgez;
    
    assign pcsource[1]= jr | j | jal | jalr;
    
    assign loadkind[0]= lh | lhu;
    assign loadkind[1]= lb | lbu;
    
    assign storekind[0]= sh;
    assign storekind[1]= sb;
    
    assign wlohi= mtlo | mthi | div | divu | multu;
    
    assign m2cal[0]= div;
    assign m2cal[1]= div | divu;
    
    assign c1= div | divu | multu;
    assign c2= mfhi;
    
    assign c3[0]= mthi;
    assign c3[1]= div | divu | multu;
   
    assign cause[0]= i_break | teq&&z;
    assign cause[1]= 1'b0;
    assign cause[2]= teq&&z;
    assign cause[3]= i_break | syscall | teq&&z;
    assign cause[4]= 1'b0;
   
endmodule

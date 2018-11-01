`timescale 1ns / 1ps

module alu(a,b,aluc,r,zero,negative);
    input [31:0] a;  //32位输入，操作数1(shift)
    input [31:0] b;  //32位输入，操作数2
    input [4:0] aluc; //5位输入，控制alu操作
    output [31:0] r;  //32位由a,b经过aluc指定的操作输出的数
    output zero; //0标志位
    //output carry; //进位标志位
    output negative; //负数标志位
    //output overflow; //溢出标志位
    
    //aluc[3:2]=00:Addu,Add,Subu,Sub
    wire [31:0] r_00;
    wire carry_00;
    wire overflow_00;
    //add_sub(a,b,aluc,r,overflow,carry);
    add_sub add_sub_(a,b,aluc[0],r_00,overflow_00,carry_00);
    
    wire [31:0] r_01;
    //and_or_xor_nor(a,b,aluc,r);
    and_or_xor_nor and_or_xor_nor_(a,b,aluc[1:0],r_01);
    
    wire [31:0] r_10;
    wire zero_10;
    wire carry_10;
    // lui_slt_sltu(a,b,aluc,r,a_equal_b,a_smaller_b);
    lui_slt_sltu lui_slt_sltu_(a,b,aluc[1:0],r_10,zero_10,carry_10);
    
    wire [31:0] r_11;
    wire carry_11;
    //barrel_shifter(a31,b4,aluc,r,carry);
    barrel_shifter barrel_shift_(a[4:0],b,aluc[1:0],r_11,carry_11);
    
    wire [31:0] r_101;
    wire [63:0] mul_result=a*b;
    assign r_101=mul_result[31:0];
    
    wire [31:0] r_100;
    clz CLZ(a,r_100);
    
    // mux6_1(r_00,r_01,r_10,r_11,r_100,r_101,aluc,r_out);
    mux6_1 mux6_1_(r_00,r_01,r_10,r_11,r_100,r_101,aluc[4:2],r);
    
    //zero
    reg zero_temp;
    always @ (r) begin
      if(!r) zero_temp=1;
      else zero_temp=0;
    end
    
    assign zero=aluc[3]&(~aluc[2])&aluc[1]&zero_10
               |(~aluc[3])&zero_temp
               |aluc[2]&zero_temp
               |(~aluc[1])&zero_temp;
    
     //carry
     //assign carry_have_00=(~aluc[3])&(~aluc[2])&(~aluc[1]); //无符号加减
     //assign carry_have_10=aluc[3]&(~aluc[2])&aluc[1]&(~aluc[0]);//无符号比较
     //assign carry_have_11=aluc[3]&aluc[2];//移位操作
     //assign carry_valid=carry_have_00|carry_have_10|carry_have_11;
     //assign carry=carry_have_00&carry_00| carry_have_10&carry_10|carry_have_11&carry_11;
    
    //overflow
    //assign overflow=overflow_00&(~aluc[3])&(~aluc[2])&(aluc[1]);
    
    //negative
    assign negative= aluc[3]&(~aluc[2])&aluc[1]&aluc[0]&carry_10 //slt
                    |(~aluc[3]&r[31])|aluc[2]&r[31] 
                    |(~aluc[1])&r[31]|(~aluc[0])&r[31];
    
endmodule

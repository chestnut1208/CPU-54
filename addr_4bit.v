`timescale 1ns / 1ps

module adder_4bits(a,b,carry_in,r,g,p);
    input [3:0] a;
    input [3:0] b;
    input carry_in;
    output [3:0] r;
    output g;
    output p;
    
    wire [3:0] reg_g;
    wire [3:0] reg_p;
    wire [4:1] carry; //第i个的carry_out,第i+1个的carry_in,1位加法器模块穿1个进位
   
   //利用输入同时生成所有g和p
   //adder_1bit(a,b,carry_in,r,g,p);
   adder_1bit adder_0(a[0],b[0],carry_in,r[0],reg_g[0],reg_p[0]);
   adder_1bit adder_1(a[1],b[1],carry[1],r[1],reg_g[1],reg_p[1]);
   adder_1bit adder_2(a[2],b[2],carry[2],r[2],reg_g[2],reg_p[2]);
   adder_1bit adder_3(a[3],b[3],carry[3],r[3],reg_g[3],reg_p[3]);
   
   //利用上面四个等式生成所有ri
   //gp4(input_g,input_p,carry_in,output_g,output_p,r);
   gp4 gp4_(reg_g,reg_p,carry_in,g,p,carry);
   
endmodule

`timescale 1ns / 1ps

module adder_16bits(a,b,carry_in,r,output_g,output_p);
    input [15:0] a;
    input [15:0] b;
    input carry_in;
    output [15:0] r;
    output output_g;
    output output_p;
    
    wire [3:0]reg_g;
    wire [3:0]reg_p;
    wire [4:1]carry;//1个4位加法器模块传1个进位
    
    //adder_4bits(a,b,carry_in,r,g,p);
    adder_4bits adder_0(a[3:0],b[3:0],carry_in,r[3:0],reg_g[0],reg_p[0]);
    adder_4bits adder_1(a[7:4],b[7:4],carry[1],r[7:4],reg_g[1],reg_p[1]);
    adder_4bits adder_2(a[11:8],b[11:8],carry[2],r[11:8],reg_g[2],reg_p[2]);
    adder_4bits adder_3(a[15:12],b[15:12],carry[3],r[15:12],reg_g[3],reg_p[3]);
    
    //gp4(input_g,input_p,carry_in,output_g,output_p,c);
    gp4 gp4_(reg_g,reg_p,carry_in,output_g,output_p,carry);
    
endmodule

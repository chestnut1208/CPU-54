`timescale 1ns / 1ps

module adder_32bits(a,b,carry_in,r,carry);
    input [31:0] a;
    input [31:0] b;
    input carry_in;
    output [31:0] r;
    output carry;
    
    wire carrytemp;
    wire [1:0]reg_p;
    wire [1:0]reg_g;
    
   //gp2
   assign  carrytemp=reg_g[0]|(reg_p[0]&carry_in);
   assign  carry=reg_g[1]|(reg_p[1]&reg_g[0])
                 |(reg_p[1]&reg_p[0]&carry_in);
                 
   //adder_16bits(a,b,carry_in,r,carryout,output_g,output_p)
   adder_16bits adder_0(a[15:0],b[15:0],carry_in,r[15:0],reg_g[0],reg_p[0]);
   adder_16bits adder_1(a[31:16],b[31:16],carrytemp,r[31:16],reg_g[1],reg_p[1]);
               
endmodule

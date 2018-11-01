`timescale 1ns / 1ps

module multidiv(a,b,m2cal,lo,hi);

    input [31:0] a;
    input [31:0] b;
    input [1:0] m2cal;
    output [31:0] lo;
    output [31:0] hi;
    
    wire [31:0] lo_1;
    wire [31:0] hi_1;
    wire [31:0] lo_0;
    wire [31:0] hi_0;
   
    wire [63:0] result;
    MULTU un_mul(a,b,result);
    
    DIVU un_div(a,b,lo_0,hi_0);
    
    DIV div(a,b,lo_1,hi_1);
    
    mux3_1 muxlo(result[31:0],lo_0,lo_1,m2cal,lo);
    mux3_1 muxhi(result[63:32],hi_0,hi_1,m2cal,hi);
    
endmodule

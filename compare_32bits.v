`timescale 1ns / 1ps

module compare_32bits(a,b,pre_result,result);
    input [31:0] a;
    input [31:0] b;
    input [2:0] pre_result;
    output [2:0] result;
    
    wire [2:0]temp_result;
    //compare_16bits(a,b,pre_result,result);
    compare_16bits compare_0(a[15:0],b[15:0],pre_result,temp_result);
    compare_16bits compare_1(a[31:16],b[31:16],temp_result,result);
    
endmodule

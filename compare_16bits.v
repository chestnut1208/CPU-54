`timescale 1ns / 1ps

module compare_16bits(a,b,pre_result,result);
    input [15:0] a;
    input [15:0] b;
    input [2:0] pre_result;
    output [2:0] result;
    
    wire [2:0]start_result=3'b010;
    wire [2:0]temp_result_0;
    wire [2:0]temp_result_1;
    wire [2:0]temp_result_2;
    //compare_4bits(a,b,pre_result,result);
    compare_4bits compare_0(a[3:0],b[3:0],start_result,temp_result_0);
    compare_4bits compare_1(a[7:4],b[7:4],temp_result_0,temp_result_1);
    compare_4bits compare_2(a[11:8],b[11:8],temp_result_1,temp_result_2);
    compare_4bits compare_3(a[15:12],b[15:12],temp_result_2,result);
    
endmodule

`timescale 1ns / 1ps

module DIVU(
    input [31:0] dividend, //被除数
    input [31:0] divisor,  //除数
    output [31:0] q, //商
    output [31:0] r //余数
    //output reg busy //除法器忙标志位（？）
    );
   
    wire [32:0] div_dend;
    assign div_dend={1'b0,dividend};
    wire [32:0] div_sor;
    assign div_sor={1'b0,divisor};
    wire [32:0] tmp_q;
    assign tmp_q= div_dend/div_sor;
    wire [32:0] tmp_r;
    assign tmp_r= div_dend%div_sor;
    
    assign q=tmp_q[31:0];
    assign r=tmp_r[31:0];
        

endmodule

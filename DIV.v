`timescale 1ns / 1ps

module DIV(
    input [31:0] dividend,
    input [31:0] divisor,
    //output reg busy,
    output [31:0] q, //ษฬ
    output [31:0] r  //ำเส
    );
  
    assign q=dividend/divisor;
    assign r=dividend%divisor;
    
endmodule

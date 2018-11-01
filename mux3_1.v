`timescale 1ns / 1ps

module mux3_1(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [1:0] choose,
    output [31:0] r
    );
    
    reg [31:0]temp;
    assign r=temp;
    always @ (a or b or c) begin
         if(choose==2'b00) temp<=a; //multu
         else if(choose==2'b10) temp<=b;  //divu
         else temp<=c;  //div
    end
endmodule

`timescale 1ns / 1ps

module mux_2(a,b,choose,c);
    input [31:0] a;
    input [31:0] b;
    input choose;
    output [31:0] c;
    
    reg [31:0]temp;
    assign c=temp;
    always @ (a or b or choose) begin
         if(choose==0) temp<=a;
         else temp<=b;
    end
    
endmodule

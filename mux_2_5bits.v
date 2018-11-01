`timescale 1ns / 1ps

module mux_2_5bits(a,b,choose,c);
    input [4:0] a;
    input [4:0] b;
    input choose;
    output [4:0] c;
    
    reg [4:0]temp;
    assign c=temp;
    always @ (a or b or choose) begin
        if(choose==0) temp<=a;
        else temp<=b;
    end
endmodule

`timescale 1ns / 1ps

module compare_4bits(a,b,pre_result,result);
    input [3:0] a;
    input [3:0] b;
    input [2:0] pre_result;
    output [2:0] result;
    
    reg [2:0]result_reg;
    assign result=result_reg;
    
    always @ (a or b or pre_result) begin
        if(a>b) result_reg=3'b100;
        else if(a<b) result_reg=3'b001;
        else result_reg=pre_result;
    end
    
endmodule

`timescale 1ns / 1ps

module HILO(clk,reset,wlohi,c3,in_lo,in_hi,out_lo,out_hi);
    input clk;
    input reset;
    input wlohi;
    input [1:0]c3;
    input [31:0] in_lo;
    input [31:0] in_hi;
    output [31:0] out_lo;
    output [31:0] out_hi;
    
    reg [31:0] lo;
    reg [31:0] hi;
    
    assign out_lo=lo;
    assign out_hi=hi;
    
    initial begin
    lo=32'b0;
    hi=32'b0;
    end
    
    always @ (negedge clk or posedge reset) begin
    if(reset) begin
        lo<=32'b0;
        hi<=32'b0;
    end
    else if(wlohi&&c3[1]) begin
        lo<=in_lo;
        hi<=in_hi;
    end
    else if(wlohi&&c3[0]) begin //hi
        lo<=lo;
        hi<=in_hi;
    end
    else if(wlohi) begin //lo
        lo<=in_lo;
        hi<=hi;
    end
    else begin
        lo<=lo;
        hi<=hi;
    end
    end
    
endmodule

`timescale 1ns / 1ps

module mux4(a,b,c,d,pcsource,mux_pc);
    input [31:0] a;
    input [31:0] b;
    input [31:0] c;
    input [31:0] d;
    input [1:0] pcsource;
    output reg [31:0]mux_pc;
    
    always @ (a or b or c or d or pcsource) begin
        case(pcsource)
        2'b00:mux_pc<=a;
        2'b01:mux_pc<=b;
        2'b10:mux_pc<=c;
        2'b11:mux_pc<=d;
        endcase
    end
    
endmodule

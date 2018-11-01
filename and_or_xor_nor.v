`timescale 1ns / 1ps

module and_or_xor_nor(a,b,aluc,r);
    input [31:0] a;
    input [31:0] b;
    input [1:0] aluc;//aluc[1:0]
    output [31:0] r;
    
    wire [31:0]r_and;
    assign r_and=a&b;
    wire [31:0]r_or;
    assign r_or=a|b;
    wire [31:0]r_xor;
    assign r_xor=a^b;
    wire [31:0]r_nor;
    assign r_nor=~(a|b);
    
    reg [31:0] r_out;
    assign r=r_out;
    
    always @(a or b or aluc) begin
    case(aluc)
    2'b00:r_out=r_and;
    2'b01:r_out=r_or;
    2'b10:r_out=r_xor;
    2'b11:r_out=r_nor;
    endcase
    end
    
endmodule

`timescale 1ns / 1ps

module lui_slt_sltu(a,b,aluc,r,a_equal_b,a_smaller_b);
    input [31:0] a;
    input [31:0] b;
    input [1:0] aluc;
    output reg [31:0] r;
    output a_equal_b;
    output a_smaller_b;
    
    wire [31:0]r_lui;
    wire [31:0]r_slt;
    assign r_lui={b[15:0],16'b0};
    //slt_32bits(a,b,aluc,r,equal,smaller);
    slt_32bits slt_(a,b,aluc[0],r_slt,a_equal_b,a_smaller_b);
    
    always @(aluc or r_lui or r_slt) begin
		if(aluc[1]) begin//slt
			r = r_slt;
		end else begin//lui
			r = r_lui;
		end
	end
    
endmodule

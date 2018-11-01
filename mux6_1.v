`timescale 1ns / 1ps

module mux6_1(r_00,r_01,r_10,r_11,r_100,r_101,aluc,r_out);
    input [31:0] r_00;
    input [31:0] r_01;
    input [31:0] r_10;
    input [31:0] r_11;
    input [31:0] r_100;
    input [31:0] r_101;
    input [4:2] aluc;
    output [31:0] r_out;
    
    reg [31:0]reg_r;
    assign r_out=reg_r;
    
    always @ (aluc or r_00 or r_01 or r_10 or r_11 or r_100 or r_101) begin
        case(aluc)
        3'b000:reg_r=r_00;
        3'b001:reg_r=r_01;
        3'b010:reg_r=r_10;
        3'b011:reg_r=r_11;
        3'b100:reg_r=r_100;
        3'b101:reg_r=r_101;
        endcase
    end
    
endmodule
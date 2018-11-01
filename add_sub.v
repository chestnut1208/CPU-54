`timescale 1ns / 1ps

module add_sub(a,b,aluc,r,overflow,carry);
    input [31:0] a;
    input [31:0] b;
    input aluc;//aluc[0]
    output [31:0] r;
    output overflow;
    output carry;
    
    wire [31:0]b_cal;
    wire carry_in;
    wire carryout;
    //negative(b_in,op_ne,b_out);
    negative negative_(b,aluc,b_cal);
    assign carry_in=(aluc)?1:0;//减法运算需要进位
    
    //adder_32bits(a,b,carry_in,r,carry);
    adder_32bits adder_32bits_(a,b_cal,carry_in,r,carryout);
    
    assign carry=(aluc&(~carryout))|((~aluc)&carryout);//???
    assign overflow=((~a[31])&(~b_cal[31])&r[31])
                    |(a[31]&b_cal[31]&(~r[31]));
    
endmodule

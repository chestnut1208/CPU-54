`timescale 1ns / 1ps

module signZeroExtend(immediate,sext,out);
    input [15:0] immediate;
    input sext;  //1:16λimmediate��չ��32λ
    output [31:0] out;
    
    assign out[15:0]=immediate;
    assign out[31:16]=sext?(immediate[15]?16'hffff:16'h0000):16'h0000;
    
endmodule

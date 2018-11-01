`timescale 1ns / 1ps

module negative(b_in,op_ne,b_out);
    input [31:0] b_in;
    input op_ne;
    output [31:0] b_out;
    
    //如果需要负数，则各位取反，再用进位标志加1
    assign b_out[0]=op_ne^b_in[0];
    assign b_out[1]=op_ne^b_in[1];
    assign b_out[2]=op_ne^b_in[2];
    assign b_out[3]=op_ne^b_in[3];
    assign b_out[4]=op_ne^b_in[4];
    assign b_out[5]=op_ne^b_in[5];
    assign b_out[6]=op_ne^b_in[6];
    assign b_out[7]=op_ne^b_in[7];
    assign b_out[8]=op_ne^b_in[8];
    assign b_out[9]=op_ne^b_in[9];
    assign b_out[10]=op_ne^b_in[10];
    assign b_out[11]=op_ne^b_in[11];
    assign b_out[12]=op_ne^b_in[12];
    assign b_out[13]=op_ne^b_in[13];
    assign b_out[14]=op_ne^b_in[14];
    assign b_out[15]=op_ne^b_in[15];
    assign b_out[16]=op_ne^b_in[16];
    assign b_out[17]=op_ne^b_in[17];
    assign b_out[18]=op_ne^b_in[18];
    assign b_out[19]=op_ne^b_in[19];
    assign b_out[20]=op_ne^b_in[20];
    assign b_out[21]=op_ne^b_in[21];
    assign b_out[22]=op_ne^b_in[22];
    assign b_out[23]=op_ne^b_in[23];
    assign b_out[24]=op_ne^b_in[24];
    assign b_out[25]=op_ne^b_in[25];
    assign b_out[26]=op_ne^b_in[26];
    assign b_out[27]=op_ne^b_in[27];
    assign b_out[28]=op_ne^b_in[28];
    assign b_out[29]=op_ne^b_in[29];
    assign b_out[30]=op_ne^b_in[30];
    assign b_out[31]=op_ne^b_in[31];
    
    
endmodule

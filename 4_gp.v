`timescale 1ns / 1ps

module gp4(input_g,input_p,carry_in,output_g,output_p,r);
    input [3:0] input_g;
    input [3:0] input_p;
    input carry_in;
    output output_g;
    output output_p;
    output [4:1] r; 
    
    assign output_p=input_p[0]&input_p[1]&input_p[2]&input_p[3];
    assign output_g=input_g[3]|(input_p[3]&input_g[2])
                    |(input_p[3]&input_p[2]&input_g[1])
                    |(input_p[3]&input_p[2]&input_p[1]&input_g[0]);
                 
    assign r[1]=input_g[0]|(input_p[0]&carry_in);
    assign r[2]=input_g[1]|(input_p[1]&input_g[0])
                |(input_p[1]&input_p[0]&carry_in);
    assign r[3]=input_g[2]|(input_p[2]&input_g[1])
                |(input_p[2]&input_p[1]&input_g[0])
                |(input_p[2]&input_p[1]&input_p[0]&carry_in);
    assign r[4]=input_g[3]|(input_p[3]&input_g[2])
                |(input_p[3]&input_p[2]&input_g[1])
                |(input_p[3]&input_p[2]&input_p[1]&input_g[0])
                |(input_p[3]&input_p[2]&input_p[1]&input_p[0]&carry_in);
                   
endmodule

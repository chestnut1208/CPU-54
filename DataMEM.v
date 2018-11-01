`timescale 1ns / 1ps

module DataMEM(a,d,clk,we,spo);
    input wire [10:0] a; //Inaddr 2048个
    input wire [31:0] d; //Indata
    input wire clk;  
    input wire we;  
    output wire [31:0] spo; //dataout
    
    reg [31:0] memory[0:2047];
    
    integer i;
    initial begin
      for(i=0;i<2048;i=i+1)  begin
        memory[i]=32'd0;
      end
    end
    
   always @(posedge clk) begin
            if(we) begin
                memory[a] <= d;
            end
        end
    
        assign spo = memory[a];
     
endmodule

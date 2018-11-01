`timescale 1ns / 1ps

module pc(clk,rst,pc_in,pc_out);
    input clk;
    input rst;
    input [31:0] pc_in;
    output reg [31:0] pc_out;
    
    initial begin
        pc_out=32'h00000000;
    end
    
    always @ (posedge clk or negedge rst) begin
        if(rst) pc_out<=32'h00000000; //高电平清零
        else begin
            pc_out<=pc_in;
        end
    end
    
endmodule

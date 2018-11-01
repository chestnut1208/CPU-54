`timescale 1ns / 1ps

module mux5_1(r,dmem_out_s,npc_0,hilo,exc_addr,m5reg,mux_m5reg);
    input [31:0] r;
    input [31:0] dmem_out_s;
    input [31:0] npc_0;
    input [31:0] hilo;
    input [31:0] exc_addr;
    input [2:0] m5reg;
    output [31:0] mux_m5reg;
    
    reg [31:0]tmp;
    assign mux_m5reg=tmp;
    
    always @ (r or dmem_out_s or npc_0 or hilo or exc_addr) begin
        if(m5reg==3'b000) tmp<=r;
        else if(m5reg==3'b001) tmp<=dmem_out_s;
        else if(m5reg==3'b010) tmp<=npc_0;
        else if(m5reg==3'b011) tmp<=hilo;
        else tmp<=exc_addr;
    end
    
endmodule

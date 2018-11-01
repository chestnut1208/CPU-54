`timescale 1ns / 1ps

module mux_bit(
    input [31:0] rt,
    input [1:0] kind,
    input sext,
    output [31:0] data
    );
    
    reg [31:0] tmp;
    assign data=tmp;
    
    always @ (rt) begin
    if(kind==2'b00) tmp<=rt;
    else if(kind==2'b01) begin
        tmp[15:0]<=rt[15:0];
        tmp[31:16]<=sext?(rt[15]?16'hffff:16'h0000):16'h0000;
    end
    else begin
        tmp[7:0]<=rt[7:0];
        tmp[31:8]<=sext?(rt[7]?24'hffffff:24'h000000):24'h000000;
    end
    end
    
endmodule

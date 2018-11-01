`timescale 1ns / 1ps

module slt_32bits(a,b,aluc,r,equal,smaller);
    input unsigned [31:0] a;
    input unsigned [31:0] b;
    input aluc; //aluc[0]
    output [31:0] r;
    output equal;
    output smaller;
    
    reg [2:0]result; //�޷��űȽϽ��
    always @(a or b) begin
		if(a > b) begin
			result = 3'b100;
		end else if(a == b) begin
			result = 3'b010;
		end else begin
			result = 3'b001; //|a|<|b|
		end
	end 
    
    //4�����
    assign r[0]=((~aluc)&result[0]) //�޷��űȽϣ�aluc=0
                |(aluc&a[31]&(~b[31])&1) //�з��űȽϣ�a[31]=1,b[31]=0,a-b+,r[0]=1
                |(aluc&a[31]&b[31]&result[0])//�з��űȽ�,a-b-,r[0]=result[0]
				|(aluc&(~a[31])&b[31]&0) //�з��űȽ�,a+b-,r[0]=0
				|(aluc&(~a[31])&(~b[31])&result[0]);//a+b+
	
	assign r[31:1]=0;
	
    assign equal=result[1];
    assign smaller=r[0]; //�޷�������smaller
    
endmodule

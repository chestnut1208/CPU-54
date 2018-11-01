`timescale 1ns / 1ps


module Regfiles(clk,rst,we,raddr1,raddr2,waddr,wdata,rdata1,rdata2);
    input clk; //�Ĵ�����ʱ���źţ��½���д������
    //input regrt; //rd or rt
    //input m2reg; //lw or others
    input rst; //reset�źţ��첽��λ���ߵ�ƽʱȫ���Ĵ�������/�ߵ�ƽʱ��Ч
    input we; //�Ĵ�����д��Ч�źţ�we=1:write��we=0:read
    //input [4:0] rs; //�����ȡ�ļĴ�����ַ
    //input [4:0] rt; //ͬ��
    //input [4:0] rd; //ͬ��
    input [4:0] raddr1;   //��ȡ���ݵļĴ�����ַ
    input [4:0] raddr2;  //��ȡ���ݵļĴ�����ַ
    input [4:0] waddr;   //д��Ĵ������ݵĵ�ַ
    //input [31:0] mem_data; //д��Ĵ���������
    input [31:0] wdata; //д�Ĵ������ݣ�������clk�½���ʱ��д��
    output [31:0] rdata1; //raddr1����Ӧ�ļĴ����������
    output [31:0] rdata2; //raddr2����Ӧ�Ĵ������������
    
    //wire [4:0] writeReg; //д�����ݵĵ�ַ
    //wire [31:0] writeData; //д������
    //assign writeReg=regrt?rt:rd;
   // assign writeData=m2reg? mem_data:r_data;
    
    reg [31:0] array_reg[31:0];  //$0��Ϊ0
    
    initial begin
        array_reg[0]=0;
    end
        
    //read
    assign rdata1=(raddr1==0)?0:array_reg[raddr1];
    assign rdata2=(raddr2==0)?0:array_reg[raddr2];
    
    //write
    //��Ϊrst�����㹦�ܣ�����Ҫ��û���õ��ļĴ���Ҳд��ȥ
    always @ (negedge clk or negedge rst) begin
        if(rst) begin
            array_reg[1]<=0;
            array_reg[2]<=0;
            array_reg[3]<=0;
            array_reg[4]<=0;
            array_reg[5]<=0;
            array_reg[6]<=0;
            array_reg[7]<=0;
            array_reg[8]<=0;
            array_reg[9]<=0;
            array_reg[10]<=0;
            array_reg[11]<=0;
            array_reg[12]<=0;
            array_reg[13]<=0;
            array_reg[14]<=0;
            array_reg[15]<=0;
            array_reg[16]<=0;
            array_reg[17]<=0;
            array_reg[18]<=0;
            array_reg[19]<=0;
            array_reg[20]<=0;
            array_reg[21]<=0;
            array_reg[22]<=0;
            array_reg[23]<=0;
            array_reg[24]<=0;
            array_reg[25]<=0;
            array_reg[26]<=0;
            array_reg[27]<=0;
            array_reg[28]<=0;
            array_reg[29]<=0;
            array_reg[30]<=0;
            array_reg[31]<=0;
        end
        if(we&&waddr)  //��ֹwriteReg=0
            array_reg[waddr]<=wdata;
    end
    

endmodule

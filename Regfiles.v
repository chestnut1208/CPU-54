`timescale 1ns / 1ps


module Regfiles(clk,rst,we,raddr1,raddr2,waddr,wdata,rdata1,rdata2);
    input clk; //寄存器组时钟信号，下降沿写入数据
    //input regrt; //rd or rt
    //input m2reg; //lw or others
    input rst; //reset信号，异步复位，高电平时全部寄存器置零/高电平时有效
    input we; //寄存器读写有效信号，we=1:write，we=0:read
    //input [4:0] rs; //所需读取的寄存器地址
    //input [4:0] rt; //同上
    //input [4:0] rd; //同上
    input [4:0] raddr1;   //读取数据的寄存器地址
    input [4:0] raddr2;  //读取数据的寄存器地址
    input [4:0] waddr;   //写入寄存器数据的地址
    //input [31:0] mem_data; //写入寄存器的数据
    input [31:0] wdata; //写寄存器数据，数据在clk下降沿时被写入
    output [31:0] rdata1; //raddr1所对应的寄存器输出数据
    output [31:0] rdata2; //raddr2所对应寄存器的输出数据
    
    //wire [4:0] writeReg; //写入数据的地址
    //wire [31:0] writeData; //写入数据
    //assign writeReg=regrt?rt:rd;
   // assign writeData=m2reg? mem_data:r_data;
    
    reg [31:0] array_reg[31:0];  //$0恒为0
    
    initial begin
        array_reg[0]=0;
    end
        
    //read
    assign rdata1=(raddr1==0)?0:array_reg[raddr1];
    assign rdata2=(raddr2==0)?0:array_reg[raddr2];
    
    //write
    //因为rst有置零功能，所以要把没有用到的寄存器也写进去
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
        if(we&&waddr)  //防止writeReg=0
            array_reg[waddr]<=wdata;
    end
    

endmodule

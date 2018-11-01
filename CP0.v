`timescale 1ns / 1ps

module CP0(clk,rst,mfc0,mtc0,pc,addr,data,exception,eret,cause,rdata,status,exc_addr);
    input clk;
    input rst;
    input mfc0; //CPU instruction is Mfc0(读CP0寄存器)
    input mtc0; //CPU instruction is Mtc0(写CP0寄存器)
    input [31:0] pc;
    input [4:0] addr;
    input [31:0] data; //Data from GP register to replace CP0 register
    input exception; //SignalException
    input eret; // Instruction is ERET(Exception Return)系统调用返回
    input [4:0] cause;
    output [31:0] rdata;  // Data from CP0 register for GP register
    output [31:0] status;
    output [31:0] exc_addr;   // Address for PC at the beginning of an exception
    
   reg [31:0] cp0_reg[31:0];
   
   integer i;
       initial begin
           for(i = 0; i <= 31; i = i + 1) begin
               cp0_reg[i] = 32'b0;
           end
       end
   
    assign rdata=(mfc0==1'b1)?cp0_reg[addr]:0;
    
 /*  reg [31:0] reg_status; //12
   reg [31:0] reg_cause;  //13
   reg [31:0] reg_epc;    //14
   reg [31:0] reg_record; //8 */
   //reg done;
   
   assign status=cp0_reg[12];
   assign exc_addr=eret?cp0_reg[14]:32'h00400000; //默认异常处理程序地址均为0x04
   
  /* always @ * begin
       if(mfc0) begin//read 
       case(addr)
       5'b01000:rdata<=reg_record;
       5'b01100:rdata<=reg_status;
       5'b01101:rdata<=reg_cause;
       5'b01110:rdata<=reg_epc;
       endcase
       end
       else if(eret&exception) begin
           rdata<=reg_epc; //异常返回当前指令地址
       end
   end */
   
   always @ (negedge clk or posedge rst) begin
       if(rst) begin  //高电平复位
       cp0_reg[8]<=0;
       cp0_reg[12]<=32'h0000000f;
       cp0_reg[13]<=0;
       cp0_reg[14]<=0;
	   //done<=0;
       end
	   else begin
       if(mtc0) begin//write
        cp0_reg[addr]<=data;
       end
		/* if(eret&done)
            cp0_reg[12]<=cp0_reg[12]>>5; //右移恢复 status，重新接受中断
        if(exception&~done) begin
            cp0_reg[13]<={25'b0000000000000000000000000,cause ,2'b00}; //SignalException(SystemCall)
            cp0_reg[14]<=pc+4;
            cp0_reg[12]<=cp0_reg[12]<<5; //响应中断异常，status寄存器的内容左移5位关中断
			done<=1;
        end*/
        if(exception) begin
            if(eret) cp0_reg[12]<=cp0_reg[12]>>5;  
            else begin
                cp0_reg[13]<={25'b0000000000000000000000000,cause ,2'b00}; //SignalException(SystemCall)
                cp0_reg[14]<=pc;
                cp0_reg[12]<=cp0_reg[12]<<5; //响应中断异常，status寄存器的内容左移5位关中断
            end
		end
		end
    end   
    
endmodule

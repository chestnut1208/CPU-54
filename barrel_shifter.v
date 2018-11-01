`timescale 1ns / 1ps

module barrel_shifter(a,b,aluc,r,carry);
    input [4:0] a; 
    input [31:0] b; //b移动a位
    input [1:0] aluc;
    output [31:0] r;
    output carry;
    
     reg [31:0] temp;
     assign r=temp;
     reg carry_temp;
     assign carry=carry_temp;
       
     always@(a or b or aluc) begin
     case(aluc)
     2'b00: begin//sra 2'b00
         temp=a[0]?{{b[31]},b[31:1]}:b;
         temp=a[1]?{{2{temp[31]}},temp[31:2]}:temp;
         temp=a[2]?{{4{temp[31]}},temp[31:4]}:temp;
         temp=a[3]?{{8{temp[31]}},temp[31:8]}:temp;
         temp=a[4]?{{16{temp[31]}},temp[31:16]}:temp;
         end
     2'b01: begin //srl
         temp=a[0]?{32'b0,b[31:1]}:b;
         temp=a[1]?{32'b0,temp[31:2]}:temp;
         temp=a[2]?{32'b0,temp[31:4]}:temp;
         temp=a[3]?{32'b0,temp[31:8]}:temp;
         temp=a[4]?{32'b0,temp[31:16]}:temp;
         end
     2'b10,2'b11:begin //slr sll
         temp=a[0]?{{b[30:0]},1'b0}:b;
         temp=a[1]?{{temp[29:0]},2'b0}:temp;
         temp=a[2]?{{temp[27:0]},4'b0}:temp;
         temp=a[3]?{{temp[23:0]},8'b0}:temp;
         temp=a[4]?{{temp[15:0]},16'b0}:temp;
         end
     endcase
     if(a==0)
         carry_temp=1'bx;//没有移位
     else begin
     if(aluc[1]) //左移
         carry_temp=b[32-a];
     else carry_temp=b[a-1];
     end
     end
       
       
endmodule

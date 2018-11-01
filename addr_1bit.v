`timescale 1ns / 1ps

//设计参考：https://www.zhihu.com/question/34428833?from=profile_question_card
module adder_1bit(a,b,carry_in,r,g,p);
    input a; //1位输入数
    input b; //1位输入数
    input carry_in; //进位
    output r; //结果
    output g; //产生
    output p; //传导
    
    assign r=a^b^carry_in;
    assign g=a&b;
    assign p=a|b;
    
endmodule

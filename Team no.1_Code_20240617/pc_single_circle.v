`timescale 1ns / 1ps
module pc_single_circle(
        input clk,               //时钟
        input rst,             //是否重置地址。1-初始化PC，否则接受新地址
        input PCSrc,             //数据选择器输入
        input [31:0] AluOutput,  //ALU计算结果
        input [31:0] curPC,  //当前指令的地址
        input branch,          //是否分支
        input en_fetch,     
        output reg[31:0] PC,
        output reg[31:0] nextPC  //下条指令的地址
    );

    reg [31:0] PCM;

    initial begin
        PC <= 0;
        nextPC <= 1;
    end

// 检测时钟下降沿计算新指令地址 
always @(negedge clk) begin
    case (PCSrc)
        1'b0: PCM <= curPC;
        1'b1: PCM <= AluOutput;
        default: PCM <= curPC;
    endcase
end

// 检测时钟上升沿更新PC或复位信号
always @(posedge clk or posedge rst) begin
    if (rst) begin // 复位信号为1时把PC归零
        PC <= 0;
        nextPC <= 1; // 在复位时将 nextPC 设置为初始值
    end
    else if (en_fetch||branch) begin
         PC <= PCM;
         nextPC <= PCM + 1;
    end
end
endmodule

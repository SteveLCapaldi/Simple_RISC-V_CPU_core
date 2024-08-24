`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 21:36:12
// Design Name: 
// Module Name: regFile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regFile(
    input clk,
    input  rst,
        
    input[4:0]  Wadd,//要写入的地址
    input[31:0]  Wdata,//д��ֵ
    input  isWreg,//写入的使能信�?

    input[4:0] Radd1,//要读取的地址1
    output reg[31:0]Rdata1,//读出的数�?1

    input[4:0] Radd2,//要读取的地址2
    output reg[31:0] Rdata2
    );

    reg[31:0] regF[0:31];//32个寄存器


    //initial begin
        //regF[5'b00000]=32'b0000_0000_0000_0000_0000_0000_0000_0001;
        //regF[5'b00001]=32'b0000_0000_0000_0000_0000_0000_0000_0010;
    //end

/*    always @(posedge clk or negedge rst) begin//�?
        if(~rst&&isWreg)begin
            regF[Wadd]<=Wdata;
        end
    end
[Synth 8-5413]：在regFile模块中，寄存器regF_reg的控制信号混合了同步和异步控制�??
在Verilog中，�?个寄存器的控制信号（如复位或时钟信号）应该是同步的或异步的，但不能同时是两�?��??
你需要检查regFile模块的代码，确保regF_reg寄存器的控制信号不是混合的�??*/
   
    always @(posedge clk) begin//�?
        if(~rst&&isWreg)begin
            regF[Wadd]<=Wdata;
        end
    end

    always @(*) begin//�?
        if(rst)begin
            Rdata1<=32'b0;
            Rdata2<=32'b0;
        end
        else begin
           Rdata1<=regF[Radd1];
           Rdata2<=regF[Radd2];
        end
            
    end
endmodule

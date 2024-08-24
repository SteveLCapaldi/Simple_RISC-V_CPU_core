`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/11 22:04:22
// Design Name: 
// Module Name: ram
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
module ram1 #(      
    parameter DWIDTH = 32,    // 数据宽度  
    parameter AWIDTH = 32,    // 地址宽度  
    parameter DEPTH  = 32     // 深度（即可以存储多少个数据项）  
)(      
    input clk,
    input rst,          // 复位信号  
    input en_fetch_data,// load使能信号  
    input en_store_data, //store使能信号
    input [AWIDTH - 1 : 0] alu_result, // 地址信号  
    input [DWIDTH - 1 : 0] Rdata2,  // 写入数据  
    output reg [DWIDTH - 1 : 0] data_m // 读取数据  `
);      
    reg [DWIDTH - 1 : 0] mem[0 : DEPTH - 1]; // RAM内存数组  
      
    // 初始化RAM内容（在仿真中，硬件中通常不需要）  
    initial begin      
        // 初始化RAM为某个值（在硬件中，这通常不是必需的）  
        mem[0]= 32'h0000_0001;
        mem[1]= 32'h0000_0002;
        mem[2]= 32'h0000_0003;
        mem[3]= 32'h0000_0004;
        mem[4]= 32'h0000_0005;
        mem[5]= 32'h0000_0006;
        mem[6]= 32'h0000_0007;
        mem[7]= 32'h0000_0008;
        mem[8]= 32'h0000_0009;
        mem[9]= 32'h0000_000A;
        mem[10]= 32'h0000_000B;
        mem[11]= 32'h0000_000C;
        mem[12]= 32'h0000_000D;
    end      
      
    // 读写逻辑  
    always @(posedge clk or negedge rst) begin      
        if (rst) begin      
            // 复位时，不执行读写操作（或可以选择将所有内存位置清零）  
           // dout的值可以设置为某个已知值或保持不变  
        end else if (en_store_data) begin      
            // 写使能时，将数据写入RAM  
            mem[alu_result] <= Rdata2;  
        end  else begin //if (en_fetch_data) begin  
            data_m <= mem[alu_result];  
        end
    end      
      
endmodule


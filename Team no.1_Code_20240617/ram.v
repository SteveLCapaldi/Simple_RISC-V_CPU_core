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
    parameter DWIDTH = 32,    // ���ݿ��  
    parameter AWIDTH = 32,    // ��ַ���  
    parameter DEPTH  = 32     // ��ȣ������Դ洢���ٸ������  
)(      
    input clk,
    input rst,          // ��λ�ź�  
    input en_fetch_data,// loadʹ���ź�  
    input en_store_data, //storeʹ���ź�
    input [AWIDTH - 1 : 0] alu_result, // ��ַ�ź�  
    input [DWIDTH - 1 : 0] Rdata2,  // д������  
    output reg [DWIDTH - 1 : 0] data_m // ��ȡ����  `
);      
    reg [DWIDTH - 1 : 0] mem[0 : DEPTH - 1]; // RAM�ڴ�����  
      
    // ��ʼ��RAM���ݣ��ڷ����У�Ӳ����ͨ������Ҫ��  
    initial begin      
        // ��ʼ��RAMΪĳ��ֵ����Ӳ���У���ͨ�����Ǳ���ģ�  
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
      
    // ��д�߼�  
    always @(posedge clk or negedge rst) begin      
        if (rst) begin      
            // ��λʱ����ִ�ж�д�����������ѡ�������ڴ�λ�����㣩  
           // dout��ֵ��������Ϊĳ����ֵ֪�򱣳ֲ���  
        end else if (en_store_data) begin      
            // дʹ��ʱ��������д��RAM  
            mem[alu_result] <= Rdata2;  
        end  else begin //if (en_fetch_data) begin  
            data_m <= mem[alu_result];  
        end
    end      
      
endmodule


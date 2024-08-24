`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 15:36:27
// Design Name: 
// Module Name: top_cpu
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


module top_cpu(clk,rst,alu_overflow);
input  clk, rst;
output alu_overflow;
wire   en_fetch,en_fetch_data,en_store_data;
wire   [31:0] PC;//The address of the instruction
wire   [31:0] alu_result;//The address of the data
wire   [31:0] instruction;
wire   [31:0] data_m;//Load this data to register
wire   [31:0] Rdata2;//Store thien_store_datas data to ram

CPU cpu_0(
    .clk(clk),
    .rst(rst),
    .alu_overflow(alu_overflow),
    .en_fetch(en_fetch),
    .en_fetch_data(en_fetch_data),
    .en_store_data(en_store_data),
    .PC(PC),
    .alu_result(alu_result),
    .instruction(instruction),
    .data_m(data_m),
    .Rdata2(Rdata2)      
);


rom1 rom_0 (  
  .rst(rst),
  .en_fetch(en_fetch),       
  .PC(PC),
  .instruction(instruction) 
);

ram1 ram_0(
  .clk(clk),
  .rst(rst),
  .en_fetch_data(en_fetch_data),
  .en_store_data(en_store_data),
  .alu_result(alu_result),
  .data_m(data_m),
  .Rdata2(Rdata2) 
);

endmodule

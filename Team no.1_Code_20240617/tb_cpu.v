`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/07 09:57:03
// Design Name: 
// Module Name: tb_cpu
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

module tb_top_cpu();

reg clk, rst;
wire [31:0] instruction;
wire [31:0] PC;
wire [31:0] Rdata2,alu_result;
wire en_fetch;
wire en_fetch_data;
wire en_store_data;
wire alu_overflow;
wire [31:0] data_m;


parameter Tclk = 20;

CPU test_cpu(
   .clk(clk),
   .rst(rst),
   .alu_overflow(alu_overflow),
   .en_fetch(en_fetch),
   .en_fetch_data(en_fetch_data),
   .en_store_data(en_store_data),
   .PC(PC),
   .alu_result(alu_result),
   .instruction(instruction),
   .Rdata2(Rdata2),
   .data_m(data_m)      
);

rom1 tb_rom (   
  .rst(rst),
  .en_fetch(en_fetch),       
  .PC(PC),
  .instruction(instruction) 
);

ram1 tb_ram(
 .clk(clk),
 .rst(rst),
 .en_fetch_data(en_fetch_data),
 .en_store_data(en_store_data),
 .alu_result(alu_result),
 .Rdata2(Rdata2), 
 .data_m(data_m)
);

initial begin
       clk=1;
       forever #(Tclk/2) clk=~clk;
 end                 

initial begin
         rst=1;
         #(Tclk*4)        rst=0; 
 end    
 

endmodule




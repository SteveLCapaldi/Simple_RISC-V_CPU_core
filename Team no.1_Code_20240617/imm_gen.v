`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/08 08:46:58
// Design Name: 
// Module Name: imm_gen
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



// 立即数扩展
module Imm_gen (
input   [31:0] inst_code,
output  reg [31:0] imm_out
);
wire [6:0] test;
assign test = inst_code[6:0];
always@(*) begin
case(test)
7'b0110011://R_type,用不到imm
  imm_out=32'b0;
7'b1100111,7'b1110011,7'b0000011,7'b0010011://I_type
  imm_out =  {{20{inst_code[31]}},inst_code[31:20]};
7'b1100011://B_type
  imm_out = {{(19){inst_code[31]}},inst_code[31],inst_code[7],inst_code[30:25],inst_code[11:8],1'b0} ;
7'b0110111,7'b0010111://U-type(LUI,AUIPC)
  imm_out =  inst_code[31:12] << 12;
7'b1101111://J_type(JAL)
  imm_out = {{10{inst_code[31]}},inst_code[31],inst_code[19:12],inst_code[20],inst_code[30:21],1'b0};
7'b0100011://S_type
  imm_out={{20{inst_code[31]}},inst_code[31],inst_code[30:25],inst_code[11:8],inst_code[7]};
default: imm_out = 32'b0;
  endcase
 end
endmodule


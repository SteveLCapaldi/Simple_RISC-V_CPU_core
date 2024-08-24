`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/27 18:54:32
// Design Name: 
// Module Name: Control
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


module Control(
input [31:0] instruction,
input clk,rst,
input BrEq,
input BrLT,
output en_fetch,
output en_fetch_data,
output en_store_data,
output PCSel,
output BrUn,
output ASel,
output BSel,
output [1:0] WBSel,
output isWreg,
output [4:0] alu_ctrl,
output [4:0] rs1,
output [4:0] rs2,
output [4:0] rd,
output branch
);

state_transition state_machine1(
    .clk(clk),
    .rst(rst),
    .instruction(instruction),
    .BrEq(BrEq),
    .BrLT(BrLT),
    .en_fetch(en_fetch),
    .en_fetch_data(en_fetch_data),
    .en_store_data(en_store_data),
    .PCSel(PCSel),
    .BrUn(BrUn),
    .ASel(ASel),
    .BSel(BSel),
    .WBSel(WBSel),
    .isWreg(isWreg),
    .alu_ctrl(alu_ctrl),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .branch(branch)
);
endmodule


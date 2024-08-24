`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/27 20:10:35
// Design Name: 
// Module Name: CPU_Single
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


module CPU(
    input clk, 
    input rst, 
    input [31:0] instruction, 
    input [31:0] data_m,
    output wire en_fetch,
    output en_fetch_data,
    output en_store_data,
    output [31:0] PC,
    output alu_overflow,
    output [31:0] alu_result,
    output [31:0]Rdata2
    );
    
    wire PCSel;
    wire BrUn;
    wire ASel;
    wire BSel;
    wire [1:0] WBSel;
    wire isWreg;
    wire [4:0] alu_ctrl;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire BrEq;
    wire BrLT;
    wire branch;

    Control control1(
        .instruction(instruction),
        .clk(clk),
        .rst(rst),
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

    datapath datapath1(
        .Wadd(rd),
        .clk(clk),
        .rst(rst),
        .PCSel(PCSel),
        .instruction(instruction),
        .data_m(data_m),
        .WBSel(WBSel),
        .BrUn(BrUn),
        .alu_ctrl(alu_ctrl),
        .ASel(ASel),
        .BSel(BSel),
        .isWreg(isWreg),
        .Radd1(rs1),
        .Radd2(rs2),
        .BrEq(BrEq),
        .BrLT(BrLT),
        .alu_overflow(alu_overflow),
        .PC(PC),
        .alu_result(alu_result),
        .Rdata2(Rdata2),
        .en_fetch(en_fetch),
        .branch(branch)
    );
endmodule
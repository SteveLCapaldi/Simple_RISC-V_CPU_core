`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 19:46:32
// Design Name: 
// Module Name: Datapath
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




module datapath(
    input clk, // 时钟信号
    input rst, // 复位信号
    input PCSel, // PC 选择
    input [31:0] instruction, // 指令
    input [31:0] data_m, //load����register������
    input [1:0]WBSel, // ѡ��д�ص��ź�
    input BrUn, // 分支无条�?
    input [4:0] alu_ctrl, // ALU 控制
    input ASel, // A 选择
    input BSel, // B 选择
    input isWreg, // �ж��Ƿ�д��
    input [4:0] Radd1, // �Ĵ�����ַ1
    input [4:0] Radd2, // �Ĵ�����ַ2
    input [4:0] Wadd, // Address for rd
    input en_fetch, 
    input branch,
    output wire [31:0] alu_result, 
    output BrEq, // 分支等于
    output BrLT, // 分支小于
    output alu_overflow, // ALU 溢出
    output wire [31:0] Rdata2,
    output wire [31:0] PC 
);
wire [31:0] nextPC;
wire [31:0] Rdata1;
wire [31:0] imm_out;
wire [31:0] wb;


pc_single_circle pc(
    .clk(clk),
    .rst(rst),
    .PCSrc(PCSel),
    .AluOutput(alu_result),
    .curPC(nextPC),
    .PC(PC),
    .nextPC(nextPC),
    .en_fetch(en_fetch),
    .branch(branch)
);



Execute execute1(
    .Data_A(Rdata1),
    .Data_B(Rdata2),
    .imm_out(imm_out),
    .pc_addr(PC),
    .BrUn(BrUn),
    .alu_ctrl(alu_ctrl),
    .ASel(ASel),
    .BSel(BSel),
    .BrEq(BrEq),
    .BrLT(BrLT),
    .alu_overflow(alu_overflow),
    .alu_result(alu_result)
);



regFile  reg_file2(
    .clk(clk),
    .rst(rst),
    .Wadd(Wadd),//要写入的地址
    .Wdata(wb),//要写入的数据
    .isWreg(isWreg),//使能信号
    .Radd1(Radd1),//要�?�取的地址1
    .Rdata1(Rdata1),//读出的数�?1
    .Radd2(Radd2),//要�?�取的地址2
    .Rdata2(Rdata2)//读出的数�?2
    
);

wb_mux wb_mux1(
    .alu_result(alu_result),
    .pc_four(nextPC),
    .data_m(data_m),
    .WBSel(WBSel),
    .wb(wb)
);


Imm_gen imm_gen1(
    .inst_code(instruction),
    .imm_out(imm_out)
);


endmodule

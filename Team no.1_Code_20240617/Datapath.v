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
    input clk, // æ—¶é’Ÿä¿¡å·
    input rst, // å¤ä½ä¿¡å·
    input PCSel, // PC é€‰æ‹©
    input [31:0] instruction, // æŒ‡ä»¤
    input [31:0] data_m, //load½øÈëregisterµÄÊı¾İ
    input [1:0]WBSel, // Ñ¡ÔñĞ´»ØµÄĞÅºÅ
    input BrUn, // åˆ†æ”¯æ— æ¡ä»?
    input [4:0] alu_ctrl, // ALU æ§åˆ¶
    input ASel, // A é€‰æ‹©
    input BSel, // B é€‰æ‹©
    input isWreg, // ÅĞ¶ÏÊÇ·ñĞ´»Ø
    input [4:0] Radd1, // ¼Ä´æÆ÷µØÖ·1
    input [4:0] Radd2, // ¼Ä´æÆ÷µØÖ·2
    input [4:0] Wadd, // Address for rd
    input en_fetch, 
    input branch,
    output wire [31:0] alu_result, 
    output BrEq, // åˆ†æ”¯ç­‰äº
    output BrLT, // åˆ†æ”¯å°äº
    output alu_overflow, // ALU æº¢å‡º
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
    .Wadd(Wadd),//è¦å†™å…¥çš„åœ°å€
    .Wdata(wb),//è¦å†™å…¥çš„æ•°æ®
    .isWreg(isWreg),//ä½¿èƒ½ä¿¡å·
    .Radd1(Radd1),//è¦è?»å–çš„åœ°å€1
    .Rdata1(Rdata1),//è¯»å‡ºçš„æ•°æ?1
    .Radd2(Radd2),//è¦è?»å–çš„åœ°å€2
    .Rdata2(Rdata2)//è¯»å‡ºçš„æ•°æ?2
    
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

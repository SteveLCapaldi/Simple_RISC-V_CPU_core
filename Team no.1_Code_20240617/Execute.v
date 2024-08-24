`timescale 1ns / 1ps

module Execute(
    Data_A, Data_B, imm_out, pc_addr, BrUn, alu_ctrl, ASel, BSel, BrEq, BrLT, alu_overflow, alu_result
    );

input [31:0] Data_A, Data_B, imm_out, pc_addr;
input BrUn;
input [4:0] alu_ctrl;
input ASel, BSel;
output BrEq, BrLT;
output alu_overflow;
output [31:0] alu_result;

wire [31:0] src_mux_result, FA_mux_result;

Branch_unit_singlecycle Branch1(
    .Data_A(Data_A),
    .Data_B(Data_B),
    .BrUn(BrUn),
    .BrEq(BrEq),
    .BrLT(BrLT)
);

imm_mux_sc mux_2(
    .imm_out(imm_out),
    .Data_B(Data_B),
    .BSel(BSel),
    .src_mux_result(src_mux_result)
);

pc_mux_sc mux_1(
    .ASel(ASel),
    .pc_addr(pc_addr),
    .Data_A(Data_A),
    .FA_mux_result(FA_mux_result)
);
    
ALU ALU1(
    .FA_mux_result(FA_mux_result),
    .src_mux_result(src_mux_result),
    .alu_ctrl(alu_ctrl),
    .alu_result(alu_result),
    .alu_overflow(alu_overflow)
);

endmodule    
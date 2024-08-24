`timescale 1ns / 1ps

module imm_mux_sc(
    imm_out,
    Data_B,
    BSel,
    src_mux_result
    );
    input [31:0] imm_out;
    input [31:0] Data_B;
    input BSel;
    output reg [31:0] src_mux_result;

always @(*) begin
    if(BSel == 1) begin
        src_mux_result = imm_out;
    end else begin
        src_mux_result = Data_B;
    end
end

endmodule

`timescale 1ns / 1ps

module pc_mux_sc(
    ASel,
    pc_addr,
    Data_A,
    FA_mux_result
    );
    input ASel;
    input [31:0] pc_addr;
    input [31:0] Data_A;
    output reg [31:0] FA_mux_result;
    
always @(*) begin
    if(ASel == 1) begin
        FA_mux_result = pc_addr;
    end else begin
        FA_mux_result = Data_A;
    end
end

endmodule

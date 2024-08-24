`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 11:54:03
// Design Name: 
// Module Name: branch_unit
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


module wb_mux(
    input [31:0] alu_result, pc_four, data_m,
    input [1:0] WBSel,
    output reg [31:0] wb
);

always @ (*) begin
    case(WBSel)
        2'b00: wb = alu_result;
        2'b01: wb = pc_four;
        2'b10: wb = data_m;
        default: wb = 32'b0;
    endcase
end

endmodule

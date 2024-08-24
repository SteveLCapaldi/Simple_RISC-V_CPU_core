`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/23 20:31:47
// Design Name: 
// Module Name: state_transition
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
//编写日历：1.PC 是否需要PC使能信号，因为也是寄存器
//3.有几类指令的imm 该如何定义

// 
//////////////////////////////////////////////////////////////////////////////////


    module state_transition(instruction,clk,rst,en_fetch,PCSel,BrUn,ASel,BSel,WBSel,isWreg,alu_ctrl,rs1,rs2,rd,en_fetch_data,en_store_data,BrEq,BrLT,branch

);
input [31:0] instruction;
input clk,rst;
input BrEq;
input BrLT;
output reg en_fetch;
output reg en_fetch_data;
output reg en_store_data;
output reg PCSel;
output reg BrUn;
output reg ASel;
output reg BSel;
output reg [1:0] WBSel;
output reg isWreg;
output reg [4:0] alu_ctrl;
output reg branch;
reg [6:0] current_state,next_state;
reg [6:0] opcode;
output reg [4:0] rs1;
output reg [4:0] rs2;
output reg [4:0] rd;

reg [6:0] func7;
reg [2:0] func3; 

parameter Initial = 7'b0000000;
parameter Fetch = 7'b0000001; 			
parameter Decode = 7'b0000010; 	
parameter Execute_R=7'b0110011;//R-type
parameter Execute_ALU_I=7'b0010011;//I-type_ALU
parameter Execute_L=7'b0000011;//L(oad)-type
parameter Execute_E=7'b1110011;//E-type
parameter Execute_S=7'b0100011;//S(otre)-type
parameter Execute_B=7'b1100011;//B-type
parameter Execute_JAL=7'b1101111;//JAL
parameter Execute_JALR=7'b1100111;//JALR
parameter Execute_LUI=7'b0110111;//LUI
parameter Execute_AUIPC=7'b0010111;//AUIPC
parameter Write_back =7'b0000100;     
parameter SLL=3'b001;
parameter SRL_SRA=3'b101;
parameter ADD_SUB=3'b000;
parameter AND=3'b111;
parameter OR=3'b110;
parameter XOR=3'b100;
parameter SLT=3'b010;
parameter SLTU=3'b011;

parameter BEQ=3'b000;
parameter BNE=3'b001;
parameter BLT=3'b100;
parameter BGE=3'b101;
parameter BLTU=3'b110;
parameter BGEU=3'b111;

parameter SLLI=3'b001;
parameter SRLI_SRAI=3'b101;
parameter ADDI=3'b000;
parameter SLTI=3'b010;
parameter SLTIU=3'b011;
parameter XORI=3'b100;
parameter ORI=3'b110;
parameter ANDI=3'b111;
parameter LB=3'b000;
parameter LH=3'b001;
parameter LW=3'b010;
parameter LBU=3'b100;
parameter LHU=3'b101;
parameter SB=3'b000;
parameter SH=3'b001;
parameter SW=3'b010;
parameter JAL=7'b1101111;
parameter JALR=7'b1100111;


always @(posedge clk or negedge rst) begin
	if(rst) begin
		opcode <= 7'b0000000;
		rs1 <= 5'b00000;
		rs2 <= 5'b00000;
		rd <= 5'b00000;
		func7 <= 7'b0000000;
		func3 <= 3'b000;
	end
	else begin
		opcode <= instruction[6:0];
		rs1 <= 5'b00000;
		rs2 <= 5'b00000;
		rd <= 5'b00000;
		if(instruction[6:0]==Execute_R) begin
			rs1 <= instruction[19:15];
			rs2 <= instruction[24:20];
			rd <= instruction[11:7];
			func7 <= instruction[31:25];
			func3 <= instruction[14:12];
		end//R-type
		else if(instruction[6:0]==Execute_ALU_I) begin
			rs1 <= instruction[19:15];
			rd <= instruction[11:7];
			func3 <= instruction[14:12];
		end//I-type_ALU
		else if(instruction[6:0]==Execute_L) begin
			rs1 <= instruction[19:15];
			rd <= instruction[11:7];
			func3 <= instruction[14:12];
		end//Execute_L
		else if(instruction[6:0]==Execute_S) begin
			rs1 <= instruction[19:15];
			rs2 <= instruction[24:20];
			func3 <= instruction[14:12];
		end//Execute_S
		else if(instruction[6:0]==Execute_B) begin
			rs1 <= instruction[19:15];
			rs2 <= instruction[24:20];
			func3 <= instruction[14:12];
		end//B-type
		else if(instruction[6:0]==Execute_JAL) begin
			rd <= instruction[11:7];
		end//JAL
		else if (instruction[6:0]==JALR) begin
			rs1 <= instruction[19:15];
			rd <= instruction[11:7];
		end//JALR
		else if(instruction[6:0]==Execute_LUI) begin
			rd <= instruction[11:7];
		end//LUI
		else if(instruction[6:0]==Execute_AUIPC) begin
			rd <= instruction[11:7];
		end//AUIPC
	end
end


always @ (posedge clk or negedge rst) begin
	if(rst)
		current_state <= Initial;
	else 
		current_state <= next_state;
end

// Below codes defines state transition for "next_state"
always @ (*) 
begin
	case (current_state)
		Initial: 
		begin
			if(!rst)
				next_state = Fetch;
			else
				next_state = Initial;
		end
		Fetch:	
		begin
			next_state = Decode;
        end
		Decode:
			begin
				case(opcode) 
                7'b0110011: next_state = Execute_R;
                7'b0010011: next_state = Execute_ALU_I;
                7'b0000011: next_state = Execute_L;
				7'b0100011: next_state = Execute_S;
				7'b1100011: next_state = Execute_B;
				7'b1101111: next_state = Execute_JAL;
				7'b1100111: next_state = Execute_JALR;
				7'b0110111: next_state = Execute_LUI;
				7'b0010111: next_state = Execute_AUIPC;
                default: next_state = Fetch;
            endcase
			end
		Execute_R: 
		begin
				next_state = Write_back;
		end
		Execute_ALU_I:
		begin
				next_state = Write_back;
		end
		Execute_L:
		begin
				next_state = Write_back;
		end
		Execute_S:
		begin
				next_state = Write_back;
		end
		Execute_B:
		begin
				next_state = Write_back;
		end
		Execute_LUI:
		begin
				next_state = Write_back;
		end
		Execute_AUIPC:
		begin
				next_state = Write_back;
		end
		Execute_JAL: next_state = Write_back;
		Execute_JALR: next_state = Write_back;
		Write_back: next_state = Fetch;
		default: next_state = current_state;
	endcase
end

// Below codes provide control signals
always @ (*) begin
	if(rst) begin
		en_fetch = 1'b0;
		PCSel = 1'b0;
		BrUn = 1'b0;
		ASel = 1'b0;
		BSel = 1'b0;
		WBSel = 2'b00;
		isWreg = 1'b0;
		alu_ctrl = 5'b00000;
		en_fetch_data=0;
		en_store_data=0;
	end
	else begin
		case (next_state) // Using next_state to decide control signals
			Initial: 
			begin
				en_fetch = 1'b0;
				PCSel = 1'b0;
				BrUn = 1'b0;
				ASel = 1'b0;
				BSel = 1'b0;
				WBSel = 2'b00;
				isWreg = 1'b0;
				alu_ctrl = 5'b11111;
				en_fetch_data=0;
				en_store_data=0;
				branch=0;
			end
			Fetch: 
			begin
				en_fetch = 1'b1;
				PCSel = 1'b0;
				BrUn = 1'b0;
				ASel = 1'b0;
				BSel = 1'b0;
				WBSel = 2'b00;
				isWreg = 1'b0;
				alu_ctrl = 5'b11111;
				en_fetch_data=0;
				en_store_data=0;
				branch=0;
			end
			Decode: 
			begin
				en_fetch = 1'b0;
				PCSel = 1'b0;
				BrUn = 1'b0;
				branch=0;
				//ASel = 1'b0;
				//BSel = 1'b0;
				WBSel = 2'b00;
				isWreg = 1'b0;
				//alu_ctrl = 5'b11111;
				case(opcode)
					Execute_R: begin
						ASel = 1'b0;
				        BSel = 1'b0;
						en_fetch_data=0;
						en_store_data=0;
						case(func3)
					        SLL: alu_ctrl = 5'b00000;
							SRL_SRA: begin
						 		if(func7==7'b0000000)
									alu_ctrl = 5'b00001;//SRL
								else
									alu_ctrl = 5'b00010;//SRA
								end
							ADD_SUB: begin
								if(func7==7'b0000000)
									alu_ctrl = 5'b00011;//ADD
								else
									alu_ctrl = 5'b00100;//SUB
								end
							AND: alu_ctrl = 5'b01001;
							OR: alu_ctrl = 5'b01000;
							XOR: alu_ctrl = 5'b00111;
							SLT: alu_ctrl = 5'b01010;
							SLTU: alu_ctrl = 5'b01011;
				     	endcase
					end
					Execute_ALU_I: begin
						en_fetch_data=0;
						en_store_data=0;
						ASel = 1'b0;
						BSel = 1'b1;
						case(func3)
							SLLI: alu_ctrl = 5'b00000;
							SRLI_SRAI: begin
								if(func7==7'b0000000)
									alu_ctrl = 5'b00001;//SRLI
								else
									alu_ctrl = 5'b00010;//SRAI
							end
							ADDI: alu_ctrl = 5'b00011;
							SLTI: alu_ctrl = 5'b01010;
							SLTIU: alu_ctrl = 5'b01011;
							XORI: alu_ctrl = 5'b00111;
							ORI: alu_ctrl = 5'b01000;
							ANDI: alu_ctrl = 5'b01001;
						endcase
					end
					Execute_L: begin
						en_fetch_data=1;
						en_store_data=0;
						ASel = 1'b0;
						BSel = 1'b1;
						WBSel = 2'b00;//
						alu_ctrl = 5'b10100;
					end
					Execute_S: begin
						en_fetch_data=0;
						en_store_data=1;
						ASel = 1'b0;
						BSel = 1'b0;
						WBSel = 2'b00;
						alu_ctrl = 5'b10101;
					end
					Execute_B: begin
						en_fetch_data=0;
						en_store_data=0;
						ASel=1'b1;
						BSel=1'b1;
						WBSel = 2'b00;
						alu_ctrl = 5'b00011;
						case(func3)
							BEQ: begin
								BrUn=1'b0;
								if(BrEq)begin
									PCSel = 1'b1;
									branch=1;
								end
								else begin
									PCSel = 1'b0;
									branch=0;
								end
							end
							BNE: begin
								BrUn=1'b0;
								if(BrEq)begin
									PCSel = 1'b0;
									branch=0;
								end
								else begin
									PCSel = 1'b1;
									branch=1;
								end
							end
							BLT: begin
								BrUn=1'b0;
								if(BrLT) begin
									PCSel = 1'b1;
									branch=1;
								end
								else begin
									PCSel = 1'b0;
									branch=0;
								end
							end
							BGE: begin
								BrUn=1'b0;
								if(BrLT) begin
									PCSel = 1'b0;
									branch=0;
								end
								else begin
									PCSel = 1'b1;
									branch=1;
								end
							end
							BLTU: begin
								BrUn=1'b1;
								if(BrLT) begin
									PCSel = 1'b1;
									branch=1;
								end
								else begin
									PCSel = 1'b0;
									branch=0;
								end
							end
							BGEU: begin
								BrUn=1'b1;
								if(BrLT) begin
									PCSel = 1'b0;
									branch=0;
								end
								else begin 
									PCSel = 1'b1;
									branch=1;
								end
							end
						endcase
					end
					Execute_JAL: begin
						branch=1;
						en_fetch_data=0;
						en_store_data=0;
						ASel=1'b1;
						BSel = 1'b1;
						WBSel = 2'b01;
						PCSel = 1'b1;
						alu_ctrl = 5'b10010;
						isWreg=1;
					end
					Execute_JALR: begin
						branch=1;
						en_fetch_data=0;
						en_store_data=0;
						ASel=1'b0;
						BSel = 1'b1;
						WBSel = 2'b01;
						PCSel = 1'b1;
						alu_ctrl = 5'b10011;
						isWreg=1;
					end
					Execute_LUI: begin
						en_fetch_data=0;
						en_store_data=0;
						ASel = 1'b0;
						BSel = 1'b1;
						WBSel = 2'b00;
						alu_ctrl = 5'b00101;
					end
					Execute_AUIPC: begin
						en_fetch_data=0;
						en_store_data=0;
						ASel = 1'b0;
						BSel = 1'b1;
						WBSel = 2'b00;
						alu_ctrl = 5'b00101;
					end
					default: begin
						en_fetch_data=0;
						en_store_data=0;
						ASel = 1'b0;
						BSel = 1'b0;
						WBSel = 2'b00;
						alu_ctrl = 5'b11111;
					end
					
				endcase
			end
			Execute_R: 
			begin
				WBSel = 2'b00;
				branch=0;
				
		    end
			Execute_ALU_I:
			begin
				WBSel = 2'b00;
				branch=0;
			end
			Execute_L:
			begin
				WBSel = 2'b10;
				branch=0;

			end
			Execute_S:
			begin
				WBSel = 2'b00;
				branch=0;

			end
			Execute_B:
			begin
				WBSel = 2'b00;
				branch=0;
			end
			Execute_JAL:
			begin
				WBSel = 2'b01;
				branch=0;
				isWreg=0;

			end
			Execute_JALR:
			begin
				WBSel = 2'b01;
				branch=0;
				isWreg = 1'b0;

			end

			Execute_LUI:
			begin
				WBSel = 2'b00;
				branch=0;

			end
			Execute_AUIPC:
			begin
				WBSel = 2'b00;
				branch=0;

			end
			Write_back:
			begin
				if(instruction[6:0]==Execute_L)
					alu_ctrl= 10100;
				else 
					alu_ctrl = alu_ctrl;
				en_fetch = 1'b0;
				branch=0;
				PCSel = 1'b0;
				BrUn = 1'b0;
				ASel = 1'b0;
				BSel = 1'b0;
				en_fetch_data=0;
				en_store_data=0;
				alu_ctrl = 5'b11111;
				if(instruction[6:0]==Execute_B||instruction[6:0]==Execute_JAL||instruction[6:0]==Execute_JALR)
					isWreg = 1'b0;
				else
				isWreg = 1'b1;
			end
			default: 
			begin
				en_fetch = 1'b0;
				branch=0;
				PCSel = 1'b0;
				BrUn = 1'b0;
				ASel = 1'b0;
				BSel = 1'b0;
				WBSel = 2'b00;
				isWreg = 1'b0;
				alu_ctrl = 5'b11111;
				en_fetch_data=0;
				en_store_data=0;
			end
		endcase
	end
end

endmodule



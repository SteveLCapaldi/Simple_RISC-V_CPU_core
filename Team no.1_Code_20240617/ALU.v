`timescale 1ns / 1ps

module ALU(
    FA_mux_result,
    src_mux_result,
    alu_ctrl,
    alu_result,
    alu_overflow
    );
    input [31:0] FA_mux_result;
    input [31:0] src_mux_result;
    input [4:0] alu_ctrl;
    output reg alu_overflow;
    output reg [31:0] alu_result;
    
wire [4:0] Opctr;//操作码
wire [7:0] append;
integer i;//循环
integer shift_amount;
//reg [32:0] temp_step;//移动位数

assign Opctr = alu_ctrl[4:0];
assign append = 32 - src_mux_result;

always @(*) begin
/*
      if(src_mux_result < 32) begin
        temp_step = src_mux_result;
      end else begin
        temp_step = 31;
      end //保存移动位数
*/      
      case(Opctr)
        5'b00000: //shift left logic (Imm)
            begin
                if(src_mux_result[5] == 0)
                    begin
                        alu_result = FA_mux_result << src_mux_result[4:0];
                    end else begin
                        alu_result = 0;
                 end
             end
        5'b00001://逻辑右移和立即数
            begin
                if(src_mux_result[5] == 0)
                    begin
                        alu_result <= FA_mux_result >> src_mux_result[4:0];
                    end else begin
                        alu_result = 0;
                 end
            end
            /*
        5'b00010://算数右移和立即数
            begin
                if(src_mux_result < 32) begin
                    alu_result <= FA_mux_result >>> src_mux_result;
                    if(src_mux_result[31] == 1) begin
                        //parameter appendx = {append{1'b1}};
                        case
                        alu_result <= { {append{1'b1}}, alu_result[31:append]};
                        for(i = 31; i >= 32 - src_mux_result; i = i - 1) begin
                            alu_result[i] = 1;
                        end //负数补1
                    end
                end else begin
                    if(src_mux_result[31] == 1) begin
                        alu_result = 32'hFFFFFFFF;
                    end else begin
                        alu_result = 0;
                    end
                end
            end
            */
         5'b00010://算数右移和立即数
                     begin
                         if(src_mux_result[5] == 0)
                             begin
                                 shift_amount = src_mux_result[4:0];
                                 alu_result = FA_mux_result >> shift_amount;
                                 if(FA_mux_result[31]  == 1)
                                     begin
                                         alu_result = {32{1'b1}} & alu_result;
                                     end
                             end else begin
                                 alu_result = 0;
                             end    
                     end
         5'b00011://加法
            begin
                alu_result = FA_mux_result + src_mux_result;
                if((FA_mux_result[31] == 1 && src_mux_result[31] == 1 && alu_result[31] == 0) ||
                   (FA_mux_result[31] == 0 && src_mux_result[31] == 0 && alu_result[31] == 1)) begin
                   alu_overflow = 1;//相加溢出
                end else begin
                   alu_overflow = 0;
                end
            end
         5'b00100://减法
            begin
                alu_result = FA_mux_result - src_mux_result;
                if((FA_mux_result[31] == 1 && src_mux_result[31] == 0 && alu_result[31] == 0) ||
                    (FA_mux_result[31] == 0 && src_mux_result[31] == 1 && alu_result[31] == 1)) begin
                    alu_overflow = 1;//相减溢出
                end else begin
                    alu_overflow = 0;
                end 
            end
         5'b00101://LUI 补充20位立即数
            begin
                alu_result = src_mux_result[19:0] << 12;
                alu_result[11:0] = 12'b0;
            end
         5'b00110://AUIPC PC+扩展imm
            begin
               alu_result = src_mux_result[19:0] << 12;
               alu_result[11:0] = 12'b0;
               alu_result = alu_result + FA_mux_result;
            end
         5'b00111://XOR
            begin
                alu_result = FA_mux_result ^ src_mux_result;
            end
         5'b01000://OR
            begin
                alu_result = FA_mux_result | src_mux_result;
            end
         5'b01001://AND
            begin
                alu_result = FA_mux_result & src_mux_result;
            end
         5'b01010://set less than
            begin
                if(FA_mux_result < src_mux_result) begin
                    alu_result = 1;
                end else begin
                    alu_result = 0;
                end
            end
         5'b01011://SLTU
            begin
                if($unsigned(FA_mux_result) < $unsigned(src_mux_result)) begin
                    alu_result = 1;
                end else begin
                    alu_result = 0;
                end
            end
         5'b01100://BEQ
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         5'b01101://BNE
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         5'b01110://BLT
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         5'b01111://BGE
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         5'b10000://BLTU
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         5'b10001://BGEU
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         5'b10010://JAL 
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         5'b10011://JALR
            begin
                alu_result = FA_mux_result + src_mux_result;
                //alu_result[0] = 1'b0;
            end
         5'b10100://L
            begin
                alu_result = FA_mux_result + src_mux_result;
            end    
         5'b10101://S
            begin
                alu_result = FA_mux_result + src_mux_result;
            end
         default: alu_result <= alu_result;
      endcase
end

endmodule
`timescale 1ns / 1ps
module pc_single_circle(
        input clk,               //ʱ��
        input rst,             //�Ƿ����õ�ַ��1-��ʼ��PC����������µ�ַ
        input PCSrc,             //����ѡ��������
        input [31:0] AluOutput,  //ALU������
        input [31:0] curPC,  //��ǰָ��ĵ�ַ
        input branch,          //�Ƿ��֧
        input en_fetch,     
        output reg[31:0] PC,
        output reg[31:0] nextPC  //����ָ��ĵ�ַ
    );

    reg [31:0] PCM;

    initial begin
        PC <= 0;
        nextPC <= 1;
    end

// ���ʱ���½��ؼ�����ָ���ַ 
always @(negedge clk) begin
    case (PCSrc)
        1'b0: PCM <= curPC;
        1'b1: PCM <= AluOutput;
        default: PCM <= curPC;
    endcase
end

// ���ʱ�������ظ���PC��λ�ź�
always @(posedge clk or posedge rst) begin
    if (rst) begin // ��λ�ź�Ϊ1ʱ��PC����
        PC <= 0;
        nextPC <= 1; // �ڸ�λʱ�� nextPC ����Ϊ��ʼֵ
    end
    else if (en_fetch||branch) begin
         PC <= PCM;
         nextPC <= PCM + 1;
    end
end
endmodule

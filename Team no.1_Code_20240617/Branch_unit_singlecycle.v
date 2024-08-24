`timescale 1ns / 1ps

module Branch_unit_singlecycle(
    Data_A,
    Data_B,
    BrUn,
    BrEq,
    BrLT
    );
    input [31:0] Data_A;
    input [31:0] Data_B;
    input BrUn;
    output reg BrEq;
    output reg BrLT;
    
always @(*) begin
    if(BrUn == 1) begin
        if($unsigned(Data_A) == $unsigned(Data_B)) begin
            BrEq = 1;
        end else  begin
            BrEq = 0;
        end
        
        if($unsigned(Data_A) < $unsigned(Data_B)) begin
            BrLT = 1;
        end else begin
            BrLT = 0;
        end
    end
    
    else begin
        if(Data_A == Data_B) begin
                BrEq = 1;
            end else  begin
                BrEq = 0;
            end
            
            if(Data_A < Data_B) begin
                BrLT = 1;
            end else begin
                BrLT = 0;
            end
    end
end

endmodule

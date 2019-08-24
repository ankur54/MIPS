module MEM_WB(clk, MemtoReg, RegWrite, MemData, AluResult, RegDest, 
            RegWrite_out, MemtoReg_out, AluResult_out, MemData_out, RegDest_out);
input clk;
input RegWrite, MemtoReg;
input [31:0] AluResult, MemData;
input [4:0] RegDest; 

output RegWrite_out, MemtoReg_out;
output [31:0] AluResult_out, MemData_out;
output [4:0] RegDest_out; 

always @(posedge clk) begin
    RegWrite_out <= RegWrite;
    MemtoReg_out <= MemtoReg;
    AluResult_out <= AluResult;
    MemData_out <= MemData;
    RegDest_out <= RegDest;
end
endmodule
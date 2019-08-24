module EX_MEM(clk, RegWrite, Memread, MemtoReg, MemWrite, AluResult, WriteData, RegDest, 
            RegWrite_out, Memread_out, MemtoReg_out, MemWrite_out, AluResult_out, WriteData_out, RegDest_out);
input clk, RegWrite, Memread, MemtoReg, MemWrite;
input [31:0] AluResult, WriteData;
input [4:0] RegDest;

output RegWrite_out, Memread_out, MemtoReg_out, MemWrite_out;
output [31:0] AluResult_out, WriteData_out;
output [4:0] RegDest_out;

always @(posedge clk) begin
    RegWrite_out <= RegWrite_out;
    Memread_out <= Memread;
    MemtoReg_out <= MemtoReg;
    MemWrite_out <= MemWrite;
    AluResult_out <= AluResult;
    WriteData_out <= WriteData;
    RegDest_out <= RegDest;
end
endmodule
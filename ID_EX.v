module ID_EX(PC_in, RegDst, reg_write, Memread, MemtoReg, MemWrite, AluSrc, AluOp, signExtImm, instrc, regData1, regData2, 
            PC_out, RegDst_out, reg_write_out,Memread_out, MemtoReg_out, MemWrite_out, AluSrc_out, AluOp_out, signExtImm_out, 
            regData1_out, regData2_out, reg_rs_EX, reg_rt_EX, reg_rd_EX);
input [31:0] regData1, regData2;
input [31:0] PC_in, signExtImm;
input RegDst, reg_write, Memread, MemtoReg, MemWrite, AluSrc;
input [3:0] AluOp;
input [14:0] instrc;

output [31:0] regData1_out, regData2_out;
output [31:0] PC_out, signExtImm_out;
output RegDst_out, reg_write_out, Memread_out, MemtoReg_out, MemWrite_out, AluSrc_out;
output [3:0] AluOp_out;
output [5:0] reg_rs_EX, reg_rt_EX, reg_rd_EX;

always @(posedge clk) begin
    PC_out <= PC_in;
    signExtImm <= signExtImm_out;
    RegDst <= RegDst_out;
    reg_write <= reg_write_out;
    Memread <= Memread_out;
    MemtoReg <= MemtoReg_out;
    MemWrite <= MemWrite_out;
    AluSrc <= AluSrc_out;
    AluOp <= AluOp_out;
    regData1_out <= regData1;
    regData2_out <= regData2;
    reg_rs_EX <= instrc[14:10];
    reg_rt_EX <= instrc[9:5];
    reg_rd_EX <= instrc[4:0];
end
endmodule
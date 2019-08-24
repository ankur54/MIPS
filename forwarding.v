module ForwardData(EX_MEM_reg_write, MEM_WB_reg_write, EX_MEM_write_dest, MEM_WB_write_dest, ID_EXE_rs, ID_EXE_rt);
input EX_MEM_reg_write, MEM_WB_reg_write;
input [4:0] EX_MEM_write_dest, MEM_WB_write_dest, ID_EXE_rs, ID_EXE_rt;
output [1:0] upper_mux_sel, lower_mux_sel;
output [1:0] comparatorMux1Sel, comparatorMux2Sel;

always @(posedge clk) begin
    if (EX_MEM_reg_write && EX_MEM_write_dest) begin
        upper_mux_sel <= (EX_MEM_write_dest == ID_EXE_rs) ? 2'b10 : 2'b00;
        lower_mux_sel <= (EX_MEM_write_dest == ID_EXE_rt) ? 2'b10 : 2'b00;
        comparatorMux1Sel <= (EX_MEM_write_dest == ID_EXE_rs) ? 2'b01 : 2'b00;
        comparatorMux2Sel <= (EX_MEM_write_dest == ID_EXE_rt) ? 2'b01 : 2'b00;
    end
    
    else if (MEM_WB_reg_write && MEM_WB_write_dest) begin
        upper_mux_sel <= (MEM_WB_write_dest == ID_EXE_rs) ? 2'b01 : 2'b00;
        lower_mux_sel <= (MEM_WB_write_dest == ID_EXE_rt) ? 2'b01 : 2'b00;
        comparatorMux1Sel <= (MEM_WB_write_dest == ID_EXE_rs) ? 2'b10 : 2'b00;
        comparatorMux2Sel <= (MEM_WB_write_dest == ID_EXE_rt) ? 2'b10 : 2'b00;
    end

    else {upper_mux_sel, lower_mux_sel, comparatorMux1Sel, comparatorMux2Sel} <= 0;
end
endmodule
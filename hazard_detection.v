module HazardDetection(clk, ID_EX_regwrite, EX_MEM_regwrite, ID_EX_rd, EX_MEM_rd, instruction, holdPC, holdIF_ID);
input ID_EX_regwrite, EX_MEM_regwrite;
input [4:0] ID_EX_rd, EX_MEM_rd;
input [31:0] instruction;
output reg holdPC, holdIF_ID;

parameter BENop_code = 6'b000100;

initial begin
    {holdIF_ID, holdPC} <= 0;
end

always @(posedge clk) begin
    if(ID_EX_regwrite && ~holdPC && ~holdIF_ID) begin
        if(ID_EX_rd == instruction[25:21] || ID_EX_rd == instruction[16:20]) {holdIF_ID, holdPC} <= 2'b11;
    end

    else if(EX_MEM_regwrite && ~holdPC && ~holdIF_ID) begin
        if(EX_MEM_rd == instruction[25:21] || EX_MEM_rd == instruction[16:20]) {holdIF_ID, holdPC} <= 2'b11;
    end 
    
    else if(instruction[31:26] == BENop_code && ~holdIF_ID && ~holdPC) {holdIF_ID, holdPC} <= 2'b11;
    else {holdIF_ID, holdPC} <= 0;
end
endmodule
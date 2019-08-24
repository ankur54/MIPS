module RegisterStore(clk, reset, read_reg_1, read_reg_2, write_data, write_reg, reg_write_en, read_data1, read_dat_2);
input [31:0] write_data;
input [4:0] read_reg_1, read_reg_2, write_reg;
input reg_write_en, reset, clk;
output reg [31:0] read_data_1, read_data_2;

reg [31:0] register[0:31];

initial begin
    register[0] <= 32'h00000000;
    register[8] <= 32'h00000001;
    register[9] <= 32'h00000002;
    register[10] <= 32'h00000000;
    register[11] <= 32'h00000000;
    register[12] <= 32'h00000000;
    register[13] <= 32'h00000000;
    register[14] <= 32'h00000000;
    register[15] <= 32'h00000000;
    register[16] <= 32'h00000000;
    register[17] <= 32'h00000000;
    register[18] <= 32'h00000003;
    register[19] <= 32'h00000003;
    register[20] <= 32'h00000004;
    register[21] <= 32'h00000000;
    register[22] <= 32'h00000008;
    register[23] <= 32'h00000000;
    register[24] <= 32'h00000000;
    register[25] <= 32'h00000000;
    register[31] <= 32'h00000000;
end

always @(negedge clk) begin
    if(reset) begin
        register[0] <= 32'h00000000;
		register[8] <= 32'h00000001;
		register[9] <= 32'h00000002;
		register[10] <= 32'h00000000;
		register[11] <= 32'h00000000;
		register[12] <= 32'h00000000;
		register[13] <= 32'h00000000;
		register[14] <= 32'h00000000;
		register[15] <= 32'h00000000;
		register[16] <= 32'h00000000;
		register[17] <= 32'h00000000;
		register[18] <= 32'h00000003;
		register[19] <= 32'h00000003;
		register[20] <= 32'h00000004;
		register[21] <= 32'h00000000;
		register[22] <= 32'h00000008;
		register[23] <= 32'h00000000;
		register[24] <= 32'h00000000;
		register[25] <= 32'h00000000;
		register[31] <= 32'h00000000;
    end

    read_data_1 <= register[read_reg_1];
    read_data_2 <= register[read_reg_2];

    if(reg_write_en) register[write_reg] <= write_data;
end
endmodule
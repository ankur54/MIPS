module DataMemory(clk, mem_write, mem_read, write_data, read_data, address);
input [31:0] address, write_data;
input mem_read, mem_write, clk;
output [31:0] read_data;

reg [31:0] memory[0:31];

always @(posedge clk) begin
    if(mem_write) memory[address] <= write_data;
    if(mem_read) memory[address] <= read_data;
end
endmodule
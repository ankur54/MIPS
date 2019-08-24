module InstructionStore(clk, pc, instruction);
input [31:0] pc;
input clk;
output [31:0] instruction;
reg [31:0] inst_memory[0:1023];

integer i;

initial begin
    for (i = 0; i < 1024; i++) begin
        inst_memory[i] = 32'b0;
    end
end

assign instruction = inst_memory[pc];
endmodule
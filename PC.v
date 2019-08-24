module PC(clk, reset, hold, nextPC, pc);

input [31:0] nextPC;
input clk, reset, hold;
output [31:0] pc;

always @(posedge clk) begin
    if (~hold) begin
        if(reset == 1'b1) pc <= 32'b0;
        else pc <= nextPC;
    end
end
endmodule // PC
module IF_ID(clk, IF_ID_hold, instrIN, PC_in, PC_out, instrOUT);
input clk, IF_ID_hold;
input [31:0] instrIN, PC_in;
output [31:0] instrOUT, PC_out;

always @(posedge clk) begin
    if(~IF_ID_hold) begin
        instrOUT <= instrIN;
        PC_out <= PC_in;
    end
end
endmodule
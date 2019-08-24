module ALUControl(ALUcontrol, ALUop, funct);
input[2:0] ALUop;
input[5:0] funct;
output reg [3:0] ALUcontrol;
 
assign ALUcontrol = (ALUop == 4'b0000) ? 4'b0000:
			        (ALUop == 4'b0001) ? 4'b0001:
			        (ALUop == 4'b0011) ? 4'b0010:
                    (ALUop == 4'b0100) ? 4'b0011:
                    (ALUop == 4'b0101) ? 4'b1000:
                    (ALUop == 4'b0010) ? 
                        ((funct == 6'b100000) ? 4'b0000:
                        (funct == 6'b100010) ? 4'b0001:
                        (funct == 6'b100100) ? 4'b0010:
                        (funct == 6'b100101) ? 4'b0011:
                        (funct == 6'b100111) ? 4'b1001:
                        (funct == 6'b101010) ? 4'b1000:
                        (funct == 6'b000000) ? 4'b0100:
                        (funct == 6'b000010) ? 4'b0101 : 4'bxxxx): 4'bxxxx;
endmodule
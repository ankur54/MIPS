module Mux_2x1 #(parameter integer N) (outData, inData1, inData2, sel);
input [N-1:0] inData1, inData2;
input sel;
output [N-1:0] outData;

assign outData <= (sel == 1'b1) ? inData1 : inData2;
endmodule
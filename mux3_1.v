module Mux_3x1 #(parameter integer N) (MuxOutput, in1, in2, in3, sel);
input [N-1:0] in1, in2, in3;
input [1:0] sel;
output [N-1:0] MuxOutput;

assign MuxOutput = (sel == 2'b00) ? in1 :
                   (sel == 2'b01) ? in2 : 
                   (sel == 2'b10) ? in3 : 32'bx;
endmodule
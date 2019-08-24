module Comparator(data1, data2, eq);
input [31:0] data1, data2;
output eq;

eq <= (data1 == data2) ? 1'b1 : 1'b0;
endmodule
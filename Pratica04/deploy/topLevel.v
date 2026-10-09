module topLevel(
	op1, 
	op2,
	result,
	SW, 
	HEX0,
	HEX1
);

parameter SIZE = 16;

input [SIZE-1:0] op1, op2;
output [SIZE:0] result;

input [7:0] SW;
output [6:0] HEX0, HEX1;

add16bits s0(op1, op2, result);
hexDisplay h0(result, HEX0);
hexDisplay h1(result, HEX1);

endmodule


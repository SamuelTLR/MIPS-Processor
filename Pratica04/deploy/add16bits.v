module add16bits (op1, op2, result);

parameter SIZE = 16;

input [SIZE-1:0] op1, op2;
output [SIZE:0] result;

wire [SIZE-1:0] w;

halfAdder1bit s0(op1[0], op2[0], w[0], result[0]);
genvar i;
generate
	for(i = 1; i < SIZE; i = i + 1) begin : gen_loop
		fulladder1bit s0(op1[i], op2[i], w[i-1], w[i], result[i]);
	end
endgenerate

assign result[SIZE] = w[SIZE-1];

endmodule





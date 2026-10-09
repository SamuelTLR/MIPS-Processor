module ExtensorDeSinal
(
	a,
	b
);

	input [15:0] a;
	output [31:0] b;
	
	assign b = {16'b0, a};

endmodule
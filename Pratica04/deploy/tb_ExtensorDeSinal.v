module tb_ExtensorDeSinal;
	reg [15:0] a = 16'b1;
	wire [31:0] b;
	
	ExtensorDeSinal m(a, b);
endmodule
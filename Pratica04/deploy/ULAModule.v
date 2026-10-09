module ULAModule(
	op1,
	op2,
	aluOp,
	zero,
	resultado,
	overflow
);

	input [31:0] op1, op2;
	input [2:0] aluOp;
	output reg [31:0] resultado;
	output reg overflow, zero;
	
	reg [31:0] temp;

	
	always @(*) begin 
		case(aluOp) 
			3'b000: resultado = op1 & op2; //and
			3'b001: resultado = op1 | op2; //or
			3'b010: 
			begin
				resultado = op1 + op2;
				overflow = op1[31] + op2[31];
			end
			
			3'b110: resultado = op1 + (~op2 + 1);
			3'b111: 
			begin
				temp = op1 + (~op2 + 1);
				resultado = 32'b0;
				if(temp < 0) 
					resultado[31] = 1;
			end
			
		endcase
		
		zero = (resultado == 32'b0);
	end



endmodule
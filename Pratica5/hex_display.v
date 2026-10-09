module hex_display(in,out);

input [2:0] in; 
output reg [6:0] out;

always @(in)
	begin
		case (in)
		3'b000: out = 7'b1111111;
		3'b001: out = 7'b1111001;
		3'b010: out = 7'b0100100;
		3'b011: out = 7'b0110000;
		3'b100: out = 7'b0011001;
		3'b101: out = 7'b0010010;
		3'b110: out = 7'b0000010;
		3'b111: out = 7'b1011000;
		endcase
	end
	
endmodule

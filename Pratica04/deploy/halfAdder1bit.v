module halfAdder1bit(a, b, c_out, s);

input a, b;
output s, c_out;

assign s = a ^ b;
assign c_out = a & b;

endmodule
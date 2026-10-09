module fulladder1bit(a, b, c_in, c_out, s);

input a, b, c_in;
output s, c_out;

assign s = a ^ b ^ c_in;
assign c_out = (~a & b & c_in) | (a & ~b & c_in) | (a & b);

endmodule
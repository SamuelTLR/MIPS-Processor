module fulladder1b (A, B, Cin, Soma, Cout);
 
input  A, B, Cin;
output Soma, Cout;
 
wire C, D, E, F, G, H, I;

nand U1 (C, A, B);
nand U2 (D, C, A);
nand U3 (E, C, B);
nand U4 (F, D, E);
nand U5 (G, F, Cin);
nand U6 (H, G, Cin);
nand U7 (I, F, G);
nand U8 (Soma, I, H);
nand U9 (Cout, G, C);
 
endmodule

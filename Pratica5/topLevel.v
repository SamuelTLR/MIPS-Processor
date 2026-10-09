module topLevel(SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY1);
	input [9:0] SW;
	input KEY1;
	
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	
	parameter sizeOfWord = 16;
	
	wire [sizeOfWord - 1:0] data1, data2;
	wire temp;
	wire clock = KEY1;
	
	/********DEFINIÇÃO DE PINOS*******
 
	SW[2:0]   -> endereço de Leitura 1
	SW[5:3] ->  endereço de Leitura 2 
	SW[8:6] -> dado para gravação
	000 -> endereço onde está sendo gravado
	
	HEX0 -> Enderço de leitura 1
	HEX1 -> ENdereço de Leitura 2
	HEX2 -> Data do EDL 1
	HEX3 -> Data do EDL 2
	HEX4 -> dado para gravação 

	**********************************/
	
	BancoDeRegistradores b0(SW[2:0], SW[5:3], SW[5:3], {13'b0, SW[7:6]}, SW[9], data1, data2, SW[8]);
	
	hex_display h0 (
	.in(SW[2:0]),
	.out(HEX0[6:0])
	);
	
	hex_display h1 (
	.in(SW[5:3]),
	.out(HEX1[6:0])
	);
	
	hex_display h2 (
	.in(data1[2:0]),
	.out(HEX2[6:0])
	);
	
	hex_display h3 (
	.in(data2[2:0]),
	.out(HEX3[6:0])
	);
	
	hex_display h4 (
	.in(SW[7:6]),
	.out(HEX4[6:0])
	);
	
	assign LEDR[0] = SW[9];
	assign LEDR[1] = KEY1;
	
	
endmodule
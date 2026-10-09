module fulladder16b (SW, KEY, LEDR, HEX0, HEX1,HEX4, HEX5, HEX6, HEX7,HEX2,HEX3, LEDG);

	input [17:0] SW;
	input [3:0] KEY;
	
	output [17:0] LEDR;
	output [0:6] HEX0, HEX1, HEX4, HEX5, HEX6, HEX7,HEX2,HEX3;
	output [7:0] LEDG;

	wire [4:0] data_out;
	
	assign LEDR = SW;

	
	/********DEFINIÇÃO DE PINOS*******
 
	SW[3:0]   -> operando 1
	SW[17:14] -> operando 2 
	SW[10]    -> cin

	**********************************/


	fulladder16bits (SW[3:0], SW[17:14], SW[10], data_out[3:0], data_out[4]);
	//					(operando1, operando2, cin, resultado, cout);


	hex_display hex_number0 (SW[3:0],HEX0);	//0-3 bits do endereço
	hex_display hex_number1 (SW[17:14],HEX2);	//17-14 bits do endereço


	hex_display hex_number2 (data_out[3:0],HEX4); //0-3 bits do data_out (conteúdo)
	hex_display hex_number3 (data_out[4],HEX5); //0-3 bits do data_out (conteúdo)
	
//DESLIGA OS HEX1, 3 E 5
assign HEX1[0]=1;
assign HEX1[1]=1;
assign HEX1[2]=1;
assign HEX1[3]=1;
assign HEX1[4]=1;
assign HEX1[5]=1;
assign HEX1[6]=1;

assign HEX3[0]=1;
assign HEX3[1]=1;
assign HEX3[2]=1;
assign HEX3[3]=1;
assign HEX3[4]=1;
assign HEX3[5]=1;
assign HEX3[6]=1;

endmodule

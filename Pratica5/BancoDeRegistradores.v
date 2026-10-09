module BancoDeRegistradores
(
address1, address2, 
writeAddress, writeData, regWrite, 
data1, data2, clock
);

	parameter sizeOfReg = 16, BitAmount_ADD_Reg= 3;


	input [BitAmount_ADD_Reg - 1:0] address1, address2, writeAddress;
	input [sizeOfReg-1:0] writeData;
	input regWrite, clock;
	output [sizeOfReg - 1:0] data1, data2;
	
	reg [sizeOfReg-1:0] banco [0:2**BitAmount_ADD_Reg-1];
	
	always @(posedge clock) begin 
		if(regWrite)
			banco[writeAddress] = writeData;
	end
	
	assign data1 = banco[address1];
	assign data2 = banco[address2];

endmodule
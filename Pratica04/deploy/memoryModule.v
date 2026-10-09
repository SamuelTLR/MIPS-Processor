module memoryModule
(
	address, 
	memWrite, 
	memRead, 
	clock, 
	writeData, 
	readData
);

	input [5:0] address;
	input memWrite, memRead, clock;
	input [15:0] writeData;
	output [15:0] readData;
	reg [7:0] memory [0:63];
	
	assign readData = memRead ? {memory[address + 1], memory[address]} : 16'b0;
	
	
	always @(posedge clock) begin
		if(memWrite && address < 63) begin
			memory[address] = writeData[7:0];
			memory[address + 1] = writeData[15:8];
		end
	end
	
endmodule
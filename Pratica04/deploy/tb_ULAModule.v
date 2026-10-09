module tb_ULAModule;

    reg [2:0] aluOp;
    wire zero, overflow;
    reg [31:0] op1, op2;
	 wire [31:0] resultado;

    ULAModule ula1(
		.op1(op1),
		.op2(op2),
		.aluOp(aluOp),
		.zero(zero),
		.resultado(resultado),
		.overflow(overflow)
	 );

    initial begin
        $monitor("time=%0t | op1=%d | op2=%d | aluOp=%b | zero=%b | resultado=%d | overflow=%b",
                 $time, op1, op2, aluOp, zero, resultado, overflow);


        // And
        aluOp = 000;
		  op1 = 32'd20;
		  op2 = 32'd30;
        #10;
			
		  // Or
        aluOp = 001;
		  op1 = 32'd20;
		  op2 = 32'd30;
        #10;
		  
		  // Soma
        aluOp = 010;
		  op1 = 32'd20;
		  op2 = 32'd30;
        #10;
		  
		  // Subtração
        aluOp = 110;
		  op1 = 32'd20;
		  op2 = 32'd30;
        #10;
		  
		  // Set Les Than
        aluOp = 111;
		  op1 = 32'd20;
		  op2 = 32'd30;
        #10;
		  
		  // Set Les Than == 0
        aluOp = 111;
		  op1 = 32'd30;
		  op2 = 32'd30;
        #10;

        $finish;
    end

endmodule
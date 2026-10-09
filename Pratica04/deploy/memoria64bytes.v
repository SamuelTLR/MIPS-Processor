module tb_memoryModule;

    reg [4:0] address;
    reg memWrite, memRead, clock;
    reg [15:0] writeData;
    wire [15:0] readData;

    memoryModule m(
        .address(address),
        .memWrite(memWrite),
        .memRead(memRead),
        .clock(clock),
        .writeData(writeData),
        .readData(readData)
    );

    // Gera clock: 0 -> 1 -> 0 -> 1...
    always #5 clock = ~clock;

    initial begin
        $monitor("time=%0t | readData=%h | address=%d | memWrite=%b | memRead=%b",
                 $time, readData, address, memWrite, memRead);

        clock = 0;

        // Escrever CA no endereço 0
        address = 5'b0;
        memWrite = 1;
        memRead = 0;
        writeData = 16'h00CA;

        #10;

        // Agora ler o endereço 0
        memWrite = 0;
        memRead = 1;

        #10;

        $finish;
    end

endmodule
`include "unidade_controle.v"
`include "nRisc_completo.v"

module tb_nRisc_final;
    reg clk, reset;
    reg [7:0] rom [255:0];
    reg [7:0] ram [255:0];

    wire [7:0] pc, mem_addr, mem_to_ram, mem_from_ram;
    wire mem_write;

    nRisc dut (
        .clk(clk),
        .reset(reset),
        .mem_instr_data(rom[pc]),
        .mem_data_out(ram[mem_addr]),
        .pc_out(pc),
        .mem_addr(mem_addr),
        .mem_data_in(mem_to_ram),
        .mem_write(mem_write)
    );

    always @(posedge clk) begin
        if (mem_write) ram[mem_addr] <= mem_to_ram;
    end

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1;

        for (integer i=0; i<256; i=i+1) ram[i] = 0;

        ram[25] = 8'd10;
        ram[26] = 8'd20;
        ram[27] = 8'd30;

        rom[0] = 8'b00010000; // LI R0, 0
        rom[1] = 8'b00010111; // LI R1, 3
        rom[2] = 8'b00000101; // ADD R1, R1 (6)
        rom[3] = 8'b00000101; // ADD R1, R1 (12)
        rom[4] = 8'b00000101; // ADD R1, R1 (24)
        rom[5] = 8'b00011101; // LI R3, 1
        rom[6] = 8'b00000111; // ADD R1, R3 (25)
        rom[7] = 8'b00101101; // LW R3, (R1) -> R3 = 10
        rom[8] = 8'b00000011; // ADD R0, R3 -> R0 = 10
        rom[9] = 8'b00011101; // LI R3, 1
        rom[10] = 8'b00000111; // ADD R1, R3 (26)
        rom[11] = 8'b00101101; // LW R3, (R1) -> R3 = 20
        rom[12] = 8'b00000011; // ADD R0, R3 -> R0 = 30
        rom[13] = 8'b00011101; // LI R3, 1
        rom[14] = 8'b00000111; // ADD R1, R3 (27)
        rom[15] = 8'b00101101; // LW R3, (R1) -> R3 = 30
        rom[16] = 8'b00000011; // ADD R0, R3 -> R0 = 60
        rom[17] = 8'b00011101; // LI R3, 1
        rom[18] = 8'b00000111; // ADD R1, R3 (28)
        rom[19] = 8'b00110001; // SW R0, (R1) -> ram[28] = 60
        rom[20] = 8'b11110000; // HALT

        #10 reset = 0;

        $display("Iniciando Simulação do nRisc...");
        $display("Tempo | PC | Instr | R0 | R1 | R3 | RAM[28]");

        repeat (50) begin
            #10;
            $display("%0d | %h | %b | %d | %d | %d | %d",
                     $time, pc, rom[pc], dut.banco[0], dut.banco[1], dut.banco[3], ram[28]);
            if (rom[pc] == 8'b11110000) begin
                $display("HALT detectado!");
                #20;
                $display("Resultado Final na RAM[28]: %d (Esperado: 60)", ram[28]);
                $finish;
            end
        end
        $finish;
    end
endmodule
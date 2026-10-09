// --- Módulos Auxiliares ---

module mux2_8(input [7:0] a, b, input sel, output [7:0] y);
    assign y = sel ? b : a;
endmodule

module mux3_8(input [7:0] a, b, c, input [1:0] sel, output [7:0] y);
    assign y = (sel == 2'b00) ? a : (sel == 2'b01) ? b : c;
endmodule

module extensor_2_8(input [1:0] in, output [7:0] out);
    assign out = {{6{in[1]}}, in}; // Extensão de sinal (usado no BEQ - offset)
endmodule

module extensor_2_8_uns(input [1:0] in, output [7:0] out);
    assign out = {6'b0, in}; // Extensão com zeros (usado no LI - imediato sem sinal)
endmodule

module extensor_4_8(input [3:0] in, output [7:0] out);
    assign out = {{4{in[3]}}, in}; // Extensão de sinal para 8 bits (JMPR)
endmodule

// --- Módulo do Processador nRisc ---

module nRisc(
    input clk,
    input reset,
    input [7:0] mem_instr_data,
    input [7:0] mem_data_out,
    output [7:0] pc_out,
    output [7:0] mem_addr,
    output [7:0] mem_data_in,
    output mem_write
);

    wire [7:0] pc_atual, pc_proximo, pc_mais_1;
    wire [7:0] instr = mem_instr_data;
    wire [3:0] opcode = instr[7:4];
    wire [1:0] rd_addr = instr[3:2];
    wire [1:0] rs_addr = instr[1:0];
    wire [1:0] imm2 = instr[1:0];
    wire [3:0] imm4 = instr[3:0];

    wire branch, memRead, regWrite, ALUOp, JiR, Ji, EscPC;
    wire [1:0] sel_MemToReg, sel_ALUSrc;

    wire [7:0] reg_data1, reg_data2, ula_res, ula_b, write_data;
    wire [7:0] imm2_ext, imm2_ext_uns, imm4_ext;
    wire zero;

    unidade_controle UC (
        .opCode(opcode), .Beqz(branch), .LerMEM(memRead), .MemToReg(sel_MemToReg),
        .EscMEM(mem_write), .EscReg(regWrite), .ULAFonte(sel_ALUSrc), .ULAOp(ALUOp),
        .JiR(JiR), .Ji(Ji), .EscPC(EscPC)
    );

    assign pc_mais_1 = pc_atual + 1;

    wire [7:0] pc_beq = pc_mais_1 + imm2_ext;
    wire [7:0] pc_jmpr = pc_mais_1 + imm4_ext;

    assign pc_proximo = Ji ? reg_data1 :
                        JiR ? pc_jmpr :
                        (branch & zero) ? pc_beq : pc_mais_1;

    reg [7:0] pc_reg;
    always @(posedge clk or posedge reset) begin
        if (reset) pc_reg <= 0;
        else if (EscPC) pc_reg <= pc_proximo;
    end
    assign pc_atual = pc_reg;
    assign pc_out = pc_atual;

    reg [7:0] banco [3:0];
    assign reg_data1 = banco[rd_addr];
    assign reg_data2 = banco[rs_addr];
    always @(posedge clk) begin
        if (regWrite) banco[rd_addr] <= write_data;
    end

    extensor_2_8     EXT2     (.in(imm2), .out(imm2_ext));
    extensor_2_8_uns EXT2_UNS (.in(imm2), .out(imm2_ext_uns));
    extensor_4_8     EXT4     (.in(imm4), .out(imm4_ext));

    mux3_8 MUX_ULA(.a(reg_data2), .b(imm2_ext), .c(8'b0), .sel(sel_ALUSrc), .y(ula_b));

    assign ula_res = ALUOp ? (reg_data1 - ula_b) : (reg_data1 + ula_b);
    assign zero = (ula_res == 0);

    assign mem_addr = reg_data2;
    assign mem_data_in = reg_data1;

    mux3_8 MUX_WB(.a(ula_res), .b(mem_data_out), .c(imm2_ext_uns), .sel(sel_MemToReg), .y(write_data));

endmodule
module unidade_controle(
    input  [3:0] opCode,
    output reg   EscReg,
    output reg [1:0] ULAFonte,
    output reg   ULAOp,
    output reg [1:0] MemToReg,
    output reg   LerMEM,
    output reg   EscMEM,
    output reg   Beqz,
    output reg   JiR,
    output reg   Ji,
    output reg   EscPC
);

    always @(*) begin
        EscReg   = 0;
        ULAFonte = 2'b00;
        ULAOp    = 0;
        MemToReg = 2'b00;
        LerMEM   = 0;
        EscMEM   = 0;
        Beqz     = 0;
        JiR      = 0;
        Ji       = 0;
        EscPC    = 1;

        case(opCode)
            4'b0000: begin EscReg = 1; end // ADD
            4'b0001: begin EscReg = 1; ULAFonte = 2'b01; MemToReg = 2'b10; end // LI
            4'b0010: begin EscReg = 1; LerMEM = 1; MemToReg = 2'b01; end // LW
            4'b0011: begin EscMEM = 1; end // SW
            4'b0100: begin ULAFonte = 2'b10; ULAOp = 1; Beqz = 1; end // BEQ
            4'b0101: begin Ji = 1; end // JMP
            4'b0110: begin EscReg = 1; ULAOp = 1; end // SUB
            4'b0111: begin JiR = 1; end // JMPR
            4'b1111: begin EscPC = 0; end // HALT
            default: begin EscPC = 1; end
        endcase
    end

endmodule
module tb_add16bits;

reg [15:0] op1, op2;
wire [16:0] result;

add16bits uut (
    .op1(op1),
    .op2(op2),
    .result(result)
);

initial begin

    op1 = 16'd5;
    op2 = 16'd3;
    #10;

    op1 = 16'd7;
    op2 = 16'd7;
    #10;

    op1 = 16'd65535;
    op2 = 16'd1;
    #10;

    $stop;

end

endmodule
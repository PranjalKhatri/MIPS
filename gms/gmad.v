module FullAdder_GateLevel (
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    wire AxorB, AandB, AxorB_and_Cin;

    xor (AxorB, A, B);
    xor (Sum, AxorB, Cin);

    and (AandB, A, B);
    and (AxorB_and_Cin, AxorB, Cin);
    or  (Cout, AandB, AxorB_and_Cin);
endmodule

module Adder32_GateLevel (
    input  [31:0] A,
    input  [31:0] B,
    output [31:0] Sum,
    output        CarryOut
);
    wire [31:0] carry;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : full_adders
            if (i == 0) begin
                FullAdder_GateLevel fa (
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(1'b0),
                    .Sum(Sum[i]),
                    .Cout(carry[i])
                );
            end else begin
                FullAdder_GateLevel fa (
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(carry[i-1]),
                    .Sum(Sum[i]),
                    .Cout(carry[i])
                );
            end
        end
    endgenerate

    assign CarryOut = carry[31];
endmodule

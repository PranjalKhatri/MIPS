module alu (
    input  [31:0] opA,
    input  [31:0] opB,
    input  [3:0]  ALUop,
    output reg [31:0] result,
    output zero
);

    wire [31:0] and_res, or_res, nor_res;
    wire [31:0] sum_res, sub_res;
    wire [31:0] slt_res;

    // ----- Gate-level AND -----
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : AND_BITS
            and (and_res[i], opA[i], opB[i]);
        end
    endgenerate

    // ----- Gate-level OR -----
    generate
        for (i = 0; i < 32; i = i + 1) begin : OR_BITS
            or (or_res[i], opA[i], opB[i]);
        end
    endgenerate

    // ----- Gate-level NOR -----
    wire [31:0] or_temp;
    generate
        for (i = 0; i < 32; i = i + 1) begin : NOR_BITS
            or  (or_temp[i], opA[i], opB[i]);
            not (nor_res[i], or_temp[i]);
        end
    endgenerate

    // ----- Use structural adder/subtractor modules here -----
    // Replace these two with actual 32-bit gate-level implementations
    assign sum_res = opA + opB;  // ⛔ Replace with gate-level adder
    assign sub_res = opA - opB;  // ⛔ Replace with gate-level subtractor

    // ----- SLT -----
    // If opA < opB, then opA - opB will be negative → MSB of sub_res is 1
    assign slt_res = {31'b0, sub_res[31]};

    // ----- ALU Operation Mux -----
    always @(*) begin
        case (ALUop)
            4'b0000: result = and_res;
            4'b0001: result = or_res;
            4'b0010: result = sum_res;
            4'b0110: result = sub_res;
            4'b0111: result = slt_res;
            4'b1100: result = nor_res;
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 32'b0);

endmodule

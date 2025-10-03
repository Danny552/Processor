module ALU(
    input  logic [31:0] S1,
    input  logic [31:0] S2,
    input  logic [3:0]  ControlUnit,
    output logic [31:0] OUT
);

    always @(*) begin
        case(ControlUnit)
            4'b0000: OUT = S1 + S2;                                		// ADD
            4'b1000: OUT = S1 - S2;                                		// SUB
            4'b0001: OUT = S1 << S2[4:0];                          		// SLL
            4'b0010: OUT = ($signed(S1) < $signed(S2)) ? 32'd1 : 32'd0; // SLT
            4'b0011: OUT = (S1 < S2) ? 32'd1 : 32'd0;              		// SLTU
            4'b0100: OUT = S1 ^ S2;                                		// XOR
            4'b0101: OUT = S1 >> S2[4:0];                          		// SRL
            4'b1101: OUT = $signed(S1) >>> S2[4:0];                		// SRA
            4'b0110: OUT = S1 | S2;                                		// OR
            4'b0111: OUT = S1 & S2;                                		// AND
            default: OUT = 32'b0;
        endcase
    end
endmodule
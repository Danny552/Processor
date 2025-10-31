module ImmGen (
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
);
    logic [6:0] opcode;
    assign opcode = instruction[6:0];

    always_comb begin
        case (opcode)
            7'b0010011, // I-type (ADDI, ORI, etc)
            7'b0000011: // I-type load (LW)
                imm_out = {{20{instruction[31]}}, instruction[31:20]};

            7'b0100011: // S-type (SW)
                imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

            default:
                imm_out = 32'b0;
        endcase
    end
endmodule

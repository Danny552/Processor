module ImmGen (
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
);
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];

    always_comb begin
        unique case (opcode)
            // -----------------------------
            // I-TYPE ARITHMETIC (ADDI, SLTI, ANDI, ORI, XORI, etc.)
            // and LOADS (LW)
            // -----------------------------
            7'b0010011, // Arithmetic immediate
            7'b0000011: // Load
                imm_out = {{20{instruction[31]}}, instruction[31:20]}; // Sign-extend imm[11:0]

            // -----------------------------
            // SHIFT IMMEDIATES (SLLI, SRLI, SRAI)
            // -----------------------------
            7'b0010011: begin
                case (funct3)
                    3'b001, 3'b101: // SLLI, SRLI, SRAI
                        imm_out = {27'b0, instruction[24:20]}; // Zero-extend shamt
                    default:
                        imm_out = {{20{instruction[31]}}, instruction[31:20]};
                endcase
            end

            // -----------------------------
            // Default (for unsupported opcodes)
            // -----------------------------
            default:
                imm_out = 32'b0;
        endcase
    end
endmodule

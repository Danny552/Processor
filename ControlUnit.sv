module ControlUnit (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] ALUctrl,
    output logic       ALUSrc,
    output logic       RegWrite,
    output logic       MemRead,
    output logic       MemWrite,
    output logic       MemToReg
);
    always_comb begin
        // Default values
        ALUctrl   = 4'b0000;
        ALUSrc    = 0;
        RegWrite  = 0;
        MemRead   = 0;
        MemWrite  = 0;
        MemToReg  = 0;

        case (opcode)
            // ---------- R-TYPE ----------
            7'b0110011: begin
                ALUSrc   = 0;
                RegWrite = 1;
                case ({funct7, funct3})
                    10'b0000000_000: ALUctrl = 4'b0010; // ADD
                    10'b0100000_000: ALUctrl = 4'b0110; // SUB
                    10'b0000000_111: ALUctrl = 4'b0000; // AND
                    10'b0000000_110: ALUctrl = 4'b0001; // OR
                    10'b0000000_100: ALUctrl = 4'b0011; // XOR
                    default:          ALUctrl = 4'b1111;
                endcase
            end

            // ---------- I-TYPE (ADDI, LW) ----------
            7'b0010011: begin
                ALUSrc   = 1;
                RegWrite = 1;
                case (funct3)
                    3'b000: ALUctrl = 4'b0010; // ADDI
                    3'b100: ALUctrl = 4'b0011; // XORI
                    3'b110: ALUctrl = 4'b0001; // ORI
                    3'b111: ALUctrl = 4'b0000; // ANDI
                    default: ALUctrl = 4'b1111;
                endcase
            end

            7'b0000011: begin // LW
                ALUSrc   = 1;
                RegWrite = 1;
                MemRead  = 1;
                MemToReg = 1;
                ALUctrl  = 4'b0010; // ADD for address
            end

            // ---------- S-TYPE ----------
            7'b0100011: begin // SW
                ALUSrc   = 1;
                RegWrite = 0;
                MemWrite = 1;
                ALUctrl  = 4'b0010; // ADD for address
            end
        endcase
    end
endmodule

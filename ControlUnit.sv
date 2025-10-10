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
        unique case (opcode)
            // ------------------------------------------------------------
            // R-type (opcode = 0110011)
            // ------------------------------------------------------------
            7'b0110011: begin
                case (funct3)
                    3'b000: ALUctrl = (funct7 == 7'b0100000) ? 4'b1000 : 4'b0000; // SUB : ADD
                    3'b001: ALUctrl = 4'b0001; // SLL
                    3'b010: ALUctrl = 4'b0010; // SLT
                    3'b011: ALUctrl = 4'b0011; // SLTU
                    3'b100: ALUctrl = 4'b0100; // XOR
                    3'b101: ALUctrl = (funct7 == 7'b0100000) ? 4'b1101 : 4'b0101; // SRA : SRL
                    3'b110: ALUctrl = 4'b0110; // OR
                    3'b111: ALUctrl = 4'b0111; // AND
                    default: ALUctrl = 4'b0000;
                endcase
            end

            // ------------------------------------------------------------
            // I-type Arithmetic (opcode = 0010011)
            // ------------------------------------------------------------
            7'b0010011: begin
                case (funct3)
                    3'b000: ALUctrl = 4'b0000; // ADDI
                    3'b010: ALUctrl = 4'b0010; // SLTI
                    3'b011: ALUctrl = 4'b0011; // SLTIU
                    3'b100: ALUctrl = 4'b0100; // XORI
                    3'b110: ALUctrl = 4'b0110; // ORI
                    3'b111: ALUctrl = 4'b0111; // ANDI
                    3'b001: ALUctrl = 4'b0001; // SLLI
                    3'b101: ALUctrl = (funct7 == 7'b0100000) ? 4'b1101 : 4'b0101; // SRAI : SRLI
                    default: ALUctrl = 4'b0000;
                endcase
            end

            // ------------------------------------------------------------
            // Load (LW) and Store (SW)
            // both use ADD for address calculation
            // ------------------------------------------------------------
            7'b0000011, // LW
            7'b0100011: begin // SW
                ALUctrl = 4'b0000; // ADD (address = base + offset)
            end

            // ------------------------------------------------------------
            // Default
            // ------------------------------------------------------------
            default: ALUctrl = 4'b0000; // NOP/ADD default
        endcase
    end

endmodule

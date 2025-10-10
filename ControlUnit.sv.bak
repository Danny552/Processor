module ControlUnit (
    input  logic [6:0] opcode,   // bits [6:0]
    input  logic [2:0] funct3,   // bits [14:12]
    input  logic [6:0] funct7,   // bits [31:25]
    output logic [3:0] ALUctrl   // control code to ALU
);

    always_comb begin
        unique case (opcode)
            7'b0110011: begin  // R-type
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
            default: ALUctrl = 4'b0000; // default (NOP/ADD)
        endcase
    end

endmodule

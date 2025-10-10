module processor (
    input logic clk,
	 input logic reset,
	 output wire [6:0] display1, display2, display3, display4, display5, display6 
);
    // =========================
    // Program Counter
    // =========================
    logic [31:0] pc;
    ProgramCounter PC_inst (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    // =========================
    // Instruction Memory
    // =========================
    logic [31:0] instruction;
    InstructionMemory IMEM (
        .pc(pc),
        .instruction(instruction)
    );

    // =========================
    // Decode instruction fields
    // =========================
    logic [6:0] opcode;
    logic [4:0] rd;
    logic [2:0] funct3;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [6:0] funct7;

    assign opcode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7 = instruction[31:25];

<<<<<<< Updated upstream
	 hexa show_display(
			.seg1(display1),
			.seg2(display2),
			.seg3(display3),
			.seg4(display4),
			.seg5(display5),
			.seg6(display6),
			.binary(rd)
	 );

    // Control unit
=======
    // =========================
    // Control Unit
    // =========================
>>>>>>> Stashed changes
    logic [3:0] alu_ctrl;
    logic       ALUSrc;      // select immediate or register as ALU input2
    logic       RegWrite;    // enable register write
    logic       MemRead;     // for loads
    logic       MemWrite;    // for stores (not yet used)
    logic       MemToReg;    // select memory or ALU result for reg write (not yet used)

    ControlUnit CU (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALUctrl(alu_ctrl),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg)
    );

    // =========================
    // Register File
    // =========================
    logic [31:0] reg_data1, reg_data2;
    logic [31:0] WriteData;

    RegisterUnit RF (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(WriteData),
        .ReadData1(reg_data1),
        .ReadData2(reg_data2)
    );

    // =========================
    // Immediate Generator
    // =========================
    logic [31:0] imm_out;
    ImmGen immGen_inst (
        .instruction(instruction),
        .imm_out(imm_out)
    );

    // =========================
    // ALU Input MUX
    // =========================
    logic [31:0] ALU_in2;
    assign ALU_in2 = (ALUSrc) ? imm_out : reg_data2;

    // =========================
    // ALU
    // =========================
    logic [31:0] alu_result;
    ALU ALU_inst (
        .S1(reg_data1),
        .S2(ALU_in2),
        .ControlUnit(alu_ctrl),
        .OUT(alu_result)
    );

    // =========================
    // Write-back selection
    // (For now: only ALU result; memory stage can be added later)
    // =========================
    assign WriteData = alu_result;

endmodule

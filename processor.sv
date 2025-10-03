module processor (
    input  logic clk,
    input  logic reset
);
    // PC
    logic [31:0] pc;
    ProgramCounter PC_inst (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    // Instruction memory
    logic [31:0] instruction;
    InstructionMemory IMEM (
        .pc(pc),
        .instruction(instruction)
    );

    // Decode instruction
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


    // Control unit
    logic [3:0] alu_ctrl;
    ControlUnit CU (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALUctrl(alu_ctrl)
    );

    // Register file
    logic [31:0] reg_data1, reg_data2, alu_result;
    RegisterUnit RF (
        .clk(clk),
        .reset(reset),
        .RegWrite(1'b1),       // always write for now
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(alu_result),
        .ReadData1(reg_data1),
        .ReadData2(reg_data2)
    );

    // ALU
    ALU ALU_inst (
        .S1(reg_data1),
        .S2(reg_data2),
        .ControlUnit(alu_ctrl),
        .OUT(alu_result)
    );

endmodule

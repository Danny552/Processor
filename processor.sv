module processor (
    input logic clk,
	 input logic reset,
	 input clock,                 // 50 MHz clock
	 input sw0,                   // reset
	 input sw1,
	 input sw2,
	 input sw3,
	 input sw4,
	 input sw5,
	 output reg [7:0] vga_red,
	 output reg [7:0] vga_green,
	 output reg [7:0] vga_blue,
	 output vga_hsync,
	 output vga_vsync,
	 output vga_clock
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
	 
    logic [3:0] alu_ctrl;
    logic       ALUSrc;      // select immediate or register as ALU input2
    logic       RegWrite;    // enable register write
    logic       MemRead;     // for loads
    logic       MemWrite;    // for stores
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
    // Data Memory
    // =========================
    logic [31:0] mem_read_data;
    DataMemory DMEM (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(alu_result),
        .WriteData(reg_data2),
        .ReadData(mem_read_data)
    );

    // =========================
    // Write-back MUX
    // =========================
    assign WriteData = (MemToReg) ? mem_read_data : alu_result;
	 
	 color color_inst(
	  .clock(clock),                 // 50 MHz clock
	  .sw0(sw0),                   // reset
	  .sw1(sw1),
	  .sw2(sw2),
	  .sw3(sw3),
	  .sw4(sw4),
	  .sw5(sw5),
	  .vga_red(vga_red),
	  .vga_green(vga_green),
	  .vga_blue(vga_blue),
	  .vga_hsync(vga_hsync),
	  .vga_vsync(vga_vsync),
	  .vga_clock(vga_clock)
	);
	 
endmodule

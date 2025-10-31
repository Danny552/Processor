module InstructionMemory (
    input  logic [31:0] pc,             
    output logic [31:0] instruction
);
    logic [31:0] mem [0:255];

    assign instruction = mem[pc[31:2]];

   initial $readmemb("MemProgram/program.bin", mem);

endmodule
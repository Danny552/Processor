module InstructionMemory (
    input  logic [31:0] pc,             
    output logic [31:0] instruction
);
    logic [31:0] mem [0:255];

    assign instruction = mem[pc[31:2]];

    //Meramente para prueba
    initial begin
        mem[0] = 32'h002081B3; // ADD x3, x1, x2
        mem[1] = 32'h40318233; // SUB x4, x3, x3
    end

endmodule
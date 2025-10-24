module ProgramMemory (
    input  logic [4:0] rd,             
    output logic [7:0] data
);
    logic [7:0] mem [0:255];

    assign data = mem[rd];

endmodule
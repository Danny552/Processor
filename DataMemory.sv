module DataMemory (
    input  logic        clk,
    input  logic        MemRead,
    input  logic        MemWrite,
    input  logic [31:0] addr,
    input  logic [31:0] WriteData,
    output logic [31:0] ReadData
);
    logic [31:0] mem [0:255];

    // Asynchronous read
    assign ReadData = (MemRead) ? mem[addr[31:2]] : 32'b0;

    // Synchronous write
    always_ff @(posedge clk) begin
        if (MemWrite)
            mem[addr[31:2]] <= WriteData;
    end

   initial $readmemb("MemProgram/memory.bin", mem);
 endmodule

module ProgramCounter (
    input  logic        clk,
    input  logic        reset,
    output logic [31:0] pc
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0;            // start address
        end else begin
            pc <= pc + 32'd4;       // next instruction
        end
    end

endmodule

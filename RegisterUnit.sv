module RegisterUnit (
    input  logic        clk,
    input  logic        reset,
    input  logic        RegWrite,
    input  logic [4:0]  rs1, rs2, rd,
    input  logic [31:0] WriteData,
    output logic [31:0] ReadData1, ReadData2
);

    logic [31:0] regs [31:0];

    assign ReadData1 = (rs1 == 5'd0) ? 32'b0 : regs[rs1];
    assign ReadData2 = (rs2 == 5'd0) ? 32'b0 : regs[rs2];

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 32; i++) begin
                regs[i] <= 32'b0;
            end
				//x1 = 12, x2 = 6, x4 = 20
				regs[1] <= 32'd12;
				regs[2] <= 32'd6;
				regs[4] <= 32'd20;
        end else if (RegWrite && (rd != 5'd0)) begin
            regs[rd] <= WriteData;
        end
    end

endmodule

module processor(
	input[31:0] S1,
	input[31:0] S2,
	input[3:0] OpCode,
	output[31:0] OUT
);

	wire [31:0] ALUIN1;
	wire [31:0] ALUIN2;
	
	assign ALUIN1 = S1;
	assign ALUIN2 = S2;
	always @(*) begin
		case(OpCode)
		4'b0000: OUT = (ALUIN1 + ALUIN2);
		4'b0001: OUT = (ALUIN1 << ALUIN2);
		4'b0010: OUT = ($signed(ALUIN1) < $signed(ALUIN2));
		4'b0011: OUT = (ALUIN1 > ALUIN2);
		4'b0100: OUT = (ALUIN1 ^ ALUIN2);
		4'b0101: OUT = (ALUIN1 >> ALUIN2);
		4'b0110: OUT = (ALUIN1 | ALUIN2);
		4'b0111: OUT = (ALUIN1 & ALUIN2);
		4'b1000: OUT = (ALUIN1 - ALUIN2);
		4'b1101: OUT = (ALUIN1 >>> ALUIN2);
		default: OUT = 32'b0;
		endcase
	end
endmodule
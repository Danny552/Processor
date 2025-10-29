module vga_display(
    input  logic clk_50MHz,
    input  logic reset,
    input  logic [31:0] pc,
    input  logic [31:0] instr_mem [0:15],   // Primeras 16 instrucciones
    input  logic [31:0] data_mem [0:7],     // Ejemplo
    output logic [3:0] VGA_R,
    output logic [3:0] VGA_G,
    output logic [3:0] VGA_B,
    output logic VGA_HS,
    output logic VGA_VS
);

function automatic [7:0] hex_to_ascii(input [3:0] nibble);
    case (nibble)
        4'h0: hex_to_ascii = "0";
        4'h1: hex_to_ascii = "1";
        4'h2: hex_to_ascii = "2";
        4'h3: hex_to_ascii = "3";
        4'h4: hex_to_ascii = "4";
        4'h5: hex_to_ascii = "5";
        4'h6: hex_to_ascii = "6";
        4'h7: hex_to_ascii = "7";
        4'h8: hex_to_ascii = "8";
        4'h9: hex_to_ascii = "9";
        4'hA: hex_to_ascii = "A";
        4'hB: hex_to_ascii = "B";
        4'hC: hex_to_ascii = "C";
        4'hD: hex_to_ascii = "D";
        4'hE: hex_to_ascii = "E";
        4'hF: hex_to_ascii = "F";
    endcase
endfunction

    // --- Divisor de reloj a 25 MHz ---
    logic clk_25MHz;
    always_ff @(posedge clk_50MHz or posedge reset)
        if (reset) clk_25MHz <= 0;
        else       clk_25MHz <= ~clk_25MHz;

    // --- VGA controller ---
    logic [9:0] x, y;
    logic video_on;

    vga_controller vga(
        .clk_25MHz(clk_25MHz),
        .reset(reset),
        .hsync(VGA_HS),
        .vsync(VGA_VS),
        .x(x),
        .y(y),
        .video_on(video_on)
    );

    // --- Texto dinámico ---
    logic [7:0] line_text [0:79];
    integer i;

    always_comb begin
        // Default: espacios
        for (i = 0; i < 80; i++)
            line_text[i] = 8'h20;

        // Línea superior: Instruction Memory (en hex)
        if (y < 80) begin
            line_text[0] = "I";
            line_text[1] = "M";
            line_text[2] = ":";
            for (i = 0; i < 8; i++) begin
                line_text[4 + i] = hex_to_ascii(instr_mem[0][31 - i*4 -: 4]);
            end
        end
        // Línea media: PC en binario
        else if (y < 160) begin
            line_text[0] = "P";
            line_text[1] = "C";
            line_text[2] = ":";
            for (i = 0; i < 32; i++)
                line_text[4 + i] = pc[31 - i] ? "1" : "0";
        end
        // Línea inferior: data_mem[0]
        else begin
            line_text[0] = "D";
            line_text[1] = "M";
            line_text[2] = ":";
            for (i = 0; i < 32; i++)
                line_text[4 + i] = data_mem[0][31 - i] ? "1" : "0";
        end
    end

    // --- Text Renderer ---
    logic pixel_on;

    text_renderer renderer(
        .clk(clk_25MHz),
        .x(x),
        .y(y),
        .video_on(video_on),
        .text_mem(line_text),
        .pixel_on(pixel_on)
    );

    assign {VGA_R, VGA_G, VGA_B} = pixel_on ? 12'hFFF : 12'h000;
endmodule

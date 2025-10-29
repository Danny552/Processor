module text_renderer(
    input  logic clk,
    input  logic [9:0] x, y,
    input  logic video_on,
    input  logic [7:0] text_mem [0:79],  // 80 caracteres máx. por línea
    output logic pixel_on
);
    // Cada carácter ocupa 8x8 píxeles
    logic [6:0] char_col = x[9:3];  // División entera entre 8
    logic [5:0] char_row = y[8:3];
    logic [2:0] pixel_x = x[2:0];
    logic [2:0] pixel_y = y[2:0];

    logic [7:0] font_line;
    logic [7:0] char_code;

    assign char_code = text_mem[char_col];

    font_rom font (
        .addr({char_code, pixel_y}),
        .data(font_line)
    );

    assign pixel_on = video_on && font_line[7 - pixel_x];
endmodule

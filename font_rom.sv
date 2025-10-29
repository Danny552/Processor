module font_rom(
    input  logic [10:0] addr,   // [char_code * 8 + row]
    output logic [7:0] data     // 8 bits de la fila del carácter
);
    logic [7:0] rom [0:2047];   // 256 caracteres * 8 filas

    initial begin
        $readmemh("font8x8.hex", rom);
    end

    assign data = rom[addr];
endmodule

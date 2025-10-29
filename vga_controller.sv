module vga_controller(
    input  logic clk_25MHz,
    input  logic reset,
    output logic hsync,
    output logic vsync,
    output logic [9:0] x,
    output logic [9:0] y,
    output logic video_on
);

    // Parámetros VGA 640x480@60Hz
    localparam H_DISPLAY = 640, H_FRONT = 16, H_SYNC = 96, H_BACK = 48;
    localparam H_TOTAL   = H_DISPLAY + H_FRONT + H_SYNC + H_BACK;

    localparam V_DISPLAY = 480, V_FRONT = 10, V_SYNC = 2, V_BACK = 33;
    localparam V_TOTAL   = V_DISPLAY + V_FRONT + V_SYNC + V_BACK;

    logic [9:0] h_count, v_count;

    always_ff @(posedge clk_25MHz or posedge reset) begin
        if (reset) begin
            h_count <= 0; v_count <= 0;
        end else begin
            if (h_count == H_TOTAL - 1) begin
                h_count <= 0;
                v_count <= (v_count == V_TOTAL - 1) ? 0 : v_count + 1;
            end else
                h_count <= h_count + 1;
        end
    end

    assign hsync = ~(h_count >= (H_DISPLAY + H_FRONT) &&
                     h_count <  (H_DISPLAY + H_FRONT + H_SYNC));
    assign vsync = ~(v_count >= (V_DISPLAY + V_FRONT) &&
                     v_count <  (V_DISPLAY + V_FRONT + V_SYNC));
    assign video_on = (h_count < H_DISPLAY) && (v_count < V_DISPLAY);
    assign x = h_count;
    assign y = v_count;
endmodule

`timescale 1ns/1ps

module processor_tb;

    // =========================
    // Signals
    // =========================
    logic clk;
    logic reset;

    // Display outputs
    wire [6:0] display1, display2, display3, display4, display5, display6;

    // =========================
    // DUT instantiation
    // =========================
    processor uut (
        .clk(clk),
        .reset(reset),
        .display1(display1),
        .display2(display2),
        .display3(display3),
        .display4(display4),
        .display5(display5),
        .display6(display6)
    );

    // =========================
    // Clock generation
    // =========================
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock (period = 10ns)
    end

    // =========================
    // Reset sequence
    // =========================
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    // =========================
    // Simulation control
    // =========================
    initial begin
        // Dump file for GTKWave (optional)
        $dumpfile("processor.vcd");
        $dumpvars(0, processor_tb);

        // Run simulation for a certain duration
        #100000; // 100 us (adjust as needed)
        $stop;   // stop simulation but keep ModelSim open
    end

endmodule

`timescale 1ns/1ps
module processor_tb;
    logic clk;
    logic reset;

    // Instantiate your processor
    processor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generator
    always #5 clk = ~clk;

    // Initialize
    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0, processor_tb);
        clk = 0;
        reset = 1;
        #10 reset = 0;

        // Run for a few cycles
        #200 $finish;
    end
endmodule

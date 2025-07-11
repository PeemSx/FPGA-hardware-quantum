`timescale 1ns/1ps
module xorshift_tb;

    reg clk = 0;
    reg reset = 1;
    wire [31:0] x;

    // Instantiate module
    xorshift32 uut (
        .clk(clk),
        .reset(reset),
        .x(x)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        $display("Start simulation...");
        $dumpfile("dump.vcd");     // for GTKWave
        $dumpvars(0, xorshift_tb);

        #10 reset = 0;
        #100 $finish;
    end

endmodule
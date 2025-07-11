`timescale 1ns / 1ps

module tb_xorshift32;

    reg clk = 0;
    reg reset = 1;
    wire [31:0] rand;

    xorshift32 uut (
        .clk(clk),
        .reset(reset),
        .rand(rand)
    );

    // สร้าง clock ความถี่ 100 MHz (10 ns)
    always #5 clk = ~clk;

    integer i;

    initial begin
        $display("=== XORSHIFT32 Testbench ===");

        // Reset ก่อน
        #10 reset = 0;

        // วนสุ่ม 10 รอบ
        for (i = 0; i < 10; i = i + 1) begin
            #10;  // รอ 1 clock cycle
            $display("Random[%0d] = %0h", i, rand);
        end

        $finish;
    end

endmodule
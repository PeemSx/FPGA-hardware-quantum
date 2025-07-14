module testbench;

    reg clk = 0;
    reg reset = 1;

    reg signed [15:0] amp00_real = 23170, amp00_imag = 0;  // ≈ sqrt(0.5)
    reg signed [15:0] amp01_real = 23170, amp01_imag = 0;
    reg signed [15:0] amp10_real = 0, amp10_imag = 0;
    reg signed [15:0] amp11_real = 0, amp11_imag = 0;

    wire [7:0] result0, result1, result2, result3;

    measurement uut (
        .clk(clk),
        .reset(reset),
        .amp00_real(amp00_real),
        .amp00_imag(amp00_imag),
        .amp01_real(amp01_real),
        .amp01_imag(amp01_imag),
        .amp10_real(amp10_real),
        .amp10_imag(amp10_imag),
        .amp11_real(amp11_real),
        .amp11_imag(amp11_imag),
        .result0(result0),
        .result1(result1),
        .result2(result2),
        .result3(result3)
    );

    integer i;

    always #5 clk = ~clk;

    initial begin
        #10 reset = 0;

        for (i = 0; i < 256; i = i + 1)
            #10; 

        $display("Measurement results:");
        $display("|00>: %d", result0);
        $display("|01>: %d", result1);
        $display("|10>: %d", result2);
        $display("|11>: %d", result3);

        $finish;
    end

endmodule
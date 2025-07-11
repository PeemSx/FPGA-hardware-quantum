module measurement (
    input clk,
    input reset,
    input signed [15:0] amp00_real,
    input signed [15:0] amp00_imag,
    input signed [15:0] amp01_real,
    input signed [15:0] amp01_imag,
    input signed [15:0] amp10_real,
    input signed [15:0] amp10_imag,
    input signed [15:0] amp11_real,
    input signed [15:0] amp11_imag,
    output reg [7:0] result0,
    output reg [7:0] result1,
    output reg [7:0] result2,
    output reg [7:0] result3
);

    wire [15:0] prob0, prob1, prob2, prob3;
    wire [15:0] cum1, cum2, cum3;
    wire [31:0] rand;
    wire [15:0] rng;

    assign prob0 = amp00_real * amp00_real + amp00_imag * amp00_imag;
    assign prob1 = amp01_real * amp01_real + amp01_imag * amp01_imag;
    assign prob2 = amp10_real * amp10_real + amp10_imag * amp10_imag;
    assign prob3 = amp11_real * amp11_real + amp11_imag * amp11_imag;

    assign cum1 = prob0 + prob1;
    assign cum2 = cum1 + prob2;
    assign cum3 = cum2 + prob3;

    assign rng = rand[15:0];

    xorshift32 rng_inst (
        .clk(clk),
        .reset(reset),
        .rand(rand)
    );

    initial begin
        #10;  // รอให้สัญญาณ stable ก่อน
        $display("Probability results:");
        $display("prob0: %d", prob0);
        $display("prob1: %d", prob1);
        $display("prob2: %d", prob2);
        $display("prob3: %d", prob3);

        $display("Cumulative results:");
        $display("cum1: %d", cum1);
        $display("cum2: %d", cum2);
        $display("cum3: %d", cum3);
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result0 <= 0;
            result1 <= 0;
            result2 <= 0;
            result3 <= 0;
        end else begin
            $display("RNG: %d", rng);
            if (rng < prob0)
                result0 <= result0 + 1;
            else if (rng < cum1)
                result1 <= result1 + 1;
            else if (rng < cum2)
                result2 <= result2 + 1;
            else if (rng < cum3)
                result3 <= result3 + 1;
        end
    end

    
endmodule
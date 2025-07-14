module measurement (
    input  wire        clk,
    input  wire        reset,

    input  wire signed [15:0] amp00_real, amp00_imag,
    input  wire signed [15:0] amp01_real, amp01_imag,
    input  wire signed [15:0] amp10_real, amp10_imag,
    input  wire signed [15:0] amp11_real, amp11_imag,

    output reg  [10:0] result0, result1, result2, result3
);

    wire [31:0] prob0 = amp00_real*amp00_real + amp00_imag*amp00_imag;
    wire [31:0] prob1 = amp01_real*amp01_real + amp01_imag*amp01_imag;
    wire [31:0] prob2 = amp10_real*amp10_real + amp10_imag*amp10_imag;
    wire [31:0] prob3 = amp11_real*amp11_real + amp11_imag*amp11_imag;

    wire [31:0] cum1  = prob0 + prob1;
    wire [31:0] cum2  = cum1 + prob2;
    wire [31:0] cum3  = cum2 + prob3;                
    
    wire [29:0] rng;
    reg [31:0] rand32;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result0 <= 0; result1 <= 0; result2 <= 0; result3 <= 0;
        end
        else begin
            rand32 = $urandom; 

            if      (rand32[31:2] <  prob0[29:0]) result0 <= result0 + 1;
            else if (rand32[31:2] <  cum1[29:0])  result1 <= result1 + 1;
            else if (rand32[31:2] <  cum2[29:0])  result2 <= result2 + 1;
            else result3 <= result3 + 1;
        end
    end
endmodule
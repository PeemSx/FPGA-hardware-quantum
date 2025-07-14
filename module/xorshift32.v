// === xorshift32 ============================================================
module xorshift32 (
    input  wire        clk,
    input  wire        reset,
    output reg  [31:0] rand
);
    reg [31:0] x;

    always @(posedge clk or posedge reset) begin     
        if (reset)
            x <= 32'h1a2b3c4d;                   
        else begin
            x <=  x ^ (x << 13);
            x <=  x ^ (x >> 17);
            x <=  x ^ (x <<  5);
        end
    end

    always @* rand = x;   
endmodule
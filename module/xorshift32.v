module xorshift32 (
    input clk,
    input reset,
    output reg [31:0] rand
);

    reg [31:0] x;
    reg [31:0] temp;
    always @(posedge clk or posedge reset) begin
        if (reset)
            x <= 32'h1a2b3c4d;  // Seed
        else begin
            temp = x ^ (x << 13);
            temp = temp ^ (temp >> 17);
            temp = temp ^ (temp << 5);
            x <= temp;
        end
    end

    always @(*) begin
        rand = x;
    end
endmodule
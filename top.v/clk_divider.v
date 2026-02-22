`timescale 1ns / 1ps

module clk_divider (
    input wire clk_in,    // 125 MHz system clock from Arty Z7
    input wire rst,       // Active-high asynchronous reset
    output reg clk_out    // 1 Hz output clock (1-second period)
);

    // 62,500,000 - 1 = 62,499,999
    parameter MAX_COUNT = 26'd62_499_999; 
    
    // A 26-bit counter is required to hold up to 62,499,999
    reg [25:0] counter;

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 26'd0;
            clk_out <= 1'b0;
        end else begin
            if (counter == MAX_COUNT) begin
                counter <= 26'd0;
                clk_out <= ~clk_out; // Toggle the clock every 0.5 seconds
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
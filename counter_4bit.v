module counter_4bit (
    input clk,               // Clock signal
    input reset,             // Reset signal (active high)
    input enable,            // Counter enable
    input up_down,           // Count direction (1: up, 0: down)
    output reg [3:0] count,  // Current count value
    output carry_out         // Carry/borrow output
);

    // Internal signals
    wire [3:0] next_count;
    wire [3:0] one = 4'b0001;  // Constant value 1 for increment/decrement
    
    // Instantiate the ALU to handle increment/decrement
    alu_4bit counter_alu (
        .a(count),
        .b(one),
        .op_select(~up_down),  // 0 for increment, 1 for decrement
        .result(next_count),
        .carry_out(carry_out)
    );
    
    // Counter register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            count <= next_count;
        end
    end
    
endmodule
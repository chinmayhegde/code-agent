module programmable_counter (
    input clk,                  // Clock signal
    input reset,                // Reset signal (active high)
    input enable,               // Counter enable
    input [1:0] mode,           // Operation mode
                               // 00: Increment
                               // 01: Decrement
                               // 10: Add input_value
                               // 11: Subtract input_value
    input [3:0] input_value,    // Value to add/subtract in modes 10/11
    output reg [3:0] count,     // Current count value
    output overflow             // Overflow/underflow indicator
);

    // Internal signals
    wire [3:0] alu_result;
    wire [3:0] operand_b;
    wire op_select;
    
    // Determine the second operand for the ALU
    // For modes 00 and 01, we use constant 1
    // For modes 10 and 11, we use the input_value
    wire [3:0] constant_one = 4'b0001;
    
    // MUX to select between constant 1 and input_value
    mux_4bit operand_select (
        .a(constant_one),
        .b(input_value),
        .sel(mode[1]),
        .y(operand_b)
    );
    
    // Determine operation type (add or subtract)
    // Mode 00: add (increment)
    // Mode 01: subtract (decrement)
    // Mode 10: add (input_value)
    // Mode 11: subtract (input_value)
    assign op_select = mode[0];  // Subtract when mode[0] is 1
    
    // ALU for arithmetic operation
    alu_4bit counter_alu (
        .a(count),
        .b(operand_b),
        .op_select(op_select),
        .result(alu_result),
        .carry_out(overflow)
    );
    
    // Counter register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            count <= alu_result;
        end
    end
    
endmodule
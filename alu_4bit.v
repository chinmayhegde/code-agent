module alu_4bit (
    input [3:0] a,           // First 4-bit input
    input [3:0] b,           // Second 4-bit input
    input op_select,         // Operation select (0: ADD, 1: SUBTRACT)
    output [3:0] result,     // 4-bit result
    output carry_out         // Carry/borrow output
);

    // Internal signals
    wire [3:0] b_complement;
    wire [3:0] adder_b_input;
    
    // Compute one's complement of B (invert bits)
    assign b_complement = ~b;
    
    // Use the MUX to select between B (for addition) or ~B (for subtraction)
    mux_4bit b_select (
        .a(b),
        .b(b_complement),
        .sel(op_select),
        .y(adder_b_input)
    );
    
    // For subtraction (A-B), we compute A + (~B) + 1
    // The +1 comes from setting cin=1 when subtracting
    wire adder_cin;
    assign adder_cin = op_select; // cin=1 when subtracting (op_select=1)
    
    // Perform the addition or subtraction using the 4-bit adder
    adder_4bit arithmetic_unit (
        .a(a),
        .b(adder_b_input),
        .cin(adder_cin),
        .sum(result),
        .cout(carry_out)
    );
    
endmodule
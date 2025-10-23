module advanced_alu_4bit (
    input [3:0] a,           // First 4-bit input
    input [3:0] b,           // Second 4-bit input
    input [1:0] op_code,     // Operation code (00: ADD, 01: SUB, 10: AND, 11: OR)
    output reg [3:0] result, // 4-bit result
    output carry_out         // Carry/borrow output (valid only for ADD/SUB)
);

    // Internal signals for the adder/subtractor
    wire [3:0] add_sub_result;
    wire [3:0] b_complement;
    wire [3:0] adder_b_input;
    wire op_select;
    
    // Assign op_select for addition/subtraction based on op_code[0]
    // op_code[0]=0 for ADD, op_code[0]=1 for SUB
    assign op_select = op_code[0];
    
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
    assign adder_cin = op_select;
    
    // Adder for arithmetic operations
    adder_4bit arithmetic_unit (
        .a(a),
        .b(adder_b_input),
        .cin(adder_cin),
        .sum(add_sub_result),
        .cout(carry_out)
    );
    
    // Logic operations computed directly
    wire [3:0] and_result, or_result;
    assign and_result = a & b;
    assign or_result = a | b;
    
    // Final output multiplexing based on op_code
    always @(*) begin
        case (op_code)
            2'b00: result = add_sub_result;  // ADD
            2'b01: result = add_sub_result;  // SUB
            2'b10: result = and_result;      // AND
            2'b11: result = or_result;       // OR
            default: result = 4'b0000;
        endcase
    end
    
endmodule
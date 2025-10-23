module advanced_alu_4bit_tb;
    // Testbench signals
    reg [3:0] a, b;
    reg [1:0] op_code;
    wire [3:0] result;
    wire carry_out;
    
    // Instantiate the advanced ALU
    advanced_alu_4bit uut (
        .a(a),
        .b(b),
        .op_code(op_code),
        .result(result),
        .carry_out(carry_out)
    );
    
    // Test stimulus
    initial begin
        // Test all operations with inputs a=7, b=3
        a = 4'b0111; // 7
        b = 4'b0011; // 3
        
        // Test case 1: Addition 7 + 3 = 10
        op_code = 2'b00; // ADD
        #10;
        $display("Test 1 - Addition: %d + %d = %d, Carry = %b", a, b, result, carry_out);
        
        // Test case 2: Subtraction 7 - 3 = 4
        op_code = 2'b01; // SUB
        #10;
        $display("Test 2 - Subtraction: %d - %d = %d, Borrow = %b", a, b, result, ~carry_out);
        
        // Test case 3: Bitwise AND 7 & 3 = 3
        op_code = 2'b10; // AND
        #10;
        $display("Test 3 - AND: %b & %b = %b", a, b, result);
        
        // Test case 4: Bitwise OR 7 | 3 = 7
        op_code = 2'b11; // OR
        #10;
        $display("Test 4 - OR: %b | %b = %b", a, b, result);
        
        // Test edge cases
        a = 4'b1111; // 15
        b = 4'b0001; // 1
        
        // Test case 5: Addition with overflow 15 + 1 = 0 (with carry)
        op_code = 2'b00; // ADD
        #10;
        $display("Test 5 - Addition with overflow: %d + %d = %d, Carry = %b", a, b, result, carry_out);
        
        // Test case 6: Bitwise operations with full bit patterns
        op_code = 2'b10; // AND
        #10;
        $display("Test 6 - AND with full bits: %b & %b = %b", a, b, result);
        
        op_code = 2'b11; // OR
        #10;
        $display("Test 7 - OR with full bits: %b | %b = %b", a, b, result);
        
        $finish;
    end
endmodule
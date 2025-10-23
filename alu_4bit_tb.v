module alu_4bit_tb;
    // Testbench signals
    reg [3:0] a, b;
    reg op_select;
    wire [3:0] result;
    wire carry_out;
    
    // Instantiate the ALU
    alu_4bit uut (
        .a(a),
        .b(b),
        .op_select(op_select),
        .result(result),
        .carry_out(carry_out)
    );
    
    // Test stimulus
    initial begin
        // Test case 1: Addition 3 + 5 = 8
        a = 4'b0011; // 3
        b = 4'b0101; // 5
        op_select = 0; // Addition
        #10;
        $display("Test 1 - Addition: %d + %d = %d, Carry = %b", a, b, result, carry_out);
        
        // Test case 2: Addition with carry 9 + 8 = 17 (overflow, result = 1, carry = 1)
        a = 4'b1001; // 9
        b = 4'b1000; // 8
        op_select = 0; // Addition
        #10;
        $display("Test 2 - Addition with carry: %d + %d = %d, Carry = %b", a, b, result, carry_out);
        
        // Test case 3: Subtraction 7 - 3 = 4
        a = 4'b0111; // 7
        b = 4'b0011; // 3
        op_select = 1; // Subtraction
        #10;
        $display("Test 3 - Subtraction: %d - %d = %d, Carry = %b", a, b, result, carry_out);
        
        // Test case 4: Subtraction with borrow 3 - 7 = -4 (in two's complement)
        a = 4'b0011; // 3
        b = 4'b0111; // 7
        op_select = 1; // Subtraction
        #10;
        $display("Test 4 - Subtraction with borrow: %d - %d = %d, Carry = %b", a, b, result, carry_out);
        
        $finish;
    end
endmodule
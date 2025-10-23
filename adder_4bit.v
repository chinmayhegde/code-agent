module adder_4bit (
    input [3:0] a,          // First 4-bit input
    input [3:0] b,          // Second 4-bit input
    input cin,              // Carry input
    output [3:0] sum,       // 4-bit sum output
    output cout             // Carry output
);

    // Internal carry signals between each full adder
    wire [2:0] carry;

    // Instantiate four full adders to create a 4-bit adder
    full_adder fa0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(carry[0])
    );

    full_adder fa1 (
        .a(a[1]),
        .b(b[1]),
        .cin(carry[0]),
        .sum(sum[1]),
        .cout(carry[1])
    );

    full_adder fa2 (
        .a(a[2]),
        .b(b[2]),
        .cin(carry[1]),
        .sum(sum[2]),
        .cout(carry[2])
    );

    full_adder fa3 (
        .a(a[3]),
        .b(b[3]),
        .cin(carry[2]),
        .sum(sum[3]),
        .cout(cout)
    );

endmodule

// Single-bit full adder module
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    // Sum is XOR of all three inputs
    assign sum = a ^ b ^ cin;
    
    // Carry out is generated if any two or all three inputs are 1
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
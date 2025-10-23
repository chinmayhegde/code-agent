module mux_4bit (
    input [3:0] a,          // Input channel 0 (4 bits)
    input [3:0] b,          // Input channel 1 (4 bits)
    input sel,              // Selection signal
    output [3:0] y          // Output (4 bits)
);

    // When sel is 0, choose input a
    // When sel is 1, choose input b
    assign y = sel ? b : a;

endmodule
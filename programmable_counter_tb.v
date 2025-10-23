module programmable_counter_tb;
    // Testbench signals
    reg clk, reset, enable;
    reg [1:0] mode;
    reg [3:0] input_value;
    wire [3:0] count;
    wire overflow;
    
    // Instantiate the programmable counter
    programmable_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mode(mode),
        .input_value(input_value),
        .count(count),
        .overflow(overflow)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;    // Start in reset state
        enable = 0;
        mode = 2'b00;  // Increment mode
        input_value = 4'b0000;
        
        // Release reset after 2 clock cycles
        #20;
        reset = 0;
        enable = 1;   // Enable the counter
        
        // Mode 00: Increment by 1 for 10 clock cycles
        mode = 2'b00;
        #100;
        
        // Mode 01: Decrement by 1 for 5 clock cycles
        mode = 2'b01;
        #50;
        
        // Mode 10: Add input_value (3) for 5 clock cycles
        mode = 2'b10;
        input_value = 4'b0011;  // Add 3
        #50;
        
        // Mode 11: Subtract input_value (2) for 5 clock cycles
        mode = 2'b11;
        input_value = 4'b0010;  // Subtract 2
        #50;
        
        // Reset the counter
        reset = 1;
        #20;
        reset = 0;
        
        // Test overflow condition in increment mode
        mode = 2'b00;
        // Start at 14, count up to trigger overflow
        // First, preset counter to 14 by adding 14
        mode = 2'b10;
        input_value = 4'b1110;  // Add 14
        #10;
        // Now increment twice to reach 15 and then overflow to 0
        mode = 2'b00;
        #30;
        
        // Test underflow in decrement mode
        reset = 1;
        #20;
        reset = 0;
        // Decrement from 0, should underflow to 15
        mode = 2'b01;
        #20;
        
        $finish;
    end
    
    // Monitor the count value
    initial begin
        $monitor("Time=%0t: Mode=%b, Count=%d, Input=%d, Overflow=%b", 
                 $time, mode, count, input_value, overflow);
    end
endmodule
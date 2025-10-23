module counter_4bit_tb;
    // Testbench signals
    reg clk, reset, enable, up_down;
    wire [3:0] count;
    wire carry_out;
    
    // Instantiate the counter
    counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .up_down(up_down),
        .count(count),
        .carry_out(carry_out)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;  // Start in reset state
        enable = 0;
        up_down = 1; // Count up
        
        // Release reset after 2 clock cycles
        #20;
        reset = 0;
        enable = 1; // Enable counting
        
        // Count up for 20 clock cycles (0 to 15 and wrap back)
        #200;
        
        // Change to count down
        up_down = 0;
        
        // Count down for 20 clock cycles
        #200;
        
        // Disable counting for 5 cycles
        enable = 0;
        #50;
        
        // Re-enable and continue counting down
        enable = 1;
        #100;
        
        // Reset the counter
        reset = 1;
        #20;
        reset = 0;
        
        // Count up again for a few cycles
        up_down = 1;
        #50;
        
        $finish;
    end
    
    // Monitor the count value
    initial begin
        $monitor("Time=%0t: Count=%d, Direction=%s, Carry=%b", 
                 $time, count, up_down ? "UP" : "DOWN", carry_out);
    end
endmodule
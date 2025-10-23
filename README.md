Demonstration of Claude 3.7 Sonnet's ability to design Verilog modules using simpler building blocks. 

List of files in this folder: 

1. **alu_4bit.v** - A basic ALU that can add or subtract 4-bit numbers
   - Uses both the mux_4bit and adder_4bit components
   - Implements two's complement subtraction

2. **advanced_alu_4bit.v** - An enhanced ALU with 4 operations:
   - ADD (00): A + B
   - SUB (01): A - B
   - AND (10): A & B
   - OR (11): A | B

3. **counter_4bit.v** - A simple 4-bit up/down counter
   - Uses the alu_4bit for increment/decrement operations
   - Synchronous reset and enable control

4. **programmable_counter.v** - A versatile 4-bit counter with multiple operation modes:
   - Increment by 1 (mode 00)
   - Decrement by 1 (mode 01)
   - Add a programmable value (mode 10)
   - Subtract a programmable value (mode 11)

Each module has a corresponding testbench file that demonstrates its functionality. The programmable counter represents the most complex design, showing how basic building blocks can be combined to create a flexible and powerful circuit.

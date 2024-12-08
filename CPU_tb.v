`timescale 1ns/1ps

module CPU_tb;
    reg clk;
    reg reset;
    wire [15:0] pc;
    reg [15:0] instr;
    wire [15:0] alu_out;
    wire mem_read;
    wire mem_write;
    reg [15:0] mem_data;

    // Instantiate the CPU
    CPU uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instr(instr),
        .alu_out(alu_out),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_data(mem_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        instr = 16'b0;
        mem_data = 16'b0;

        // Apply reset
        #20;
        reset = 0;

        // Test instructions
        // ADD R1, R2, R3 (R1 = R2 + R3)
        instr = 16'b0001_0001_0010_0011;
        #10;

        // SUB R4, R5, R6 (R4 = R5 - R6)
        instr = 16'b0010_0100_0101_0110;
        #10;

        // AND R7, R8, R9 (R7 = R8 & R9)
        instr = 16'b0011_0111_1000_1001;
        #10;

        // OR R10, R11, R12 (R10 = R11 | R12)
        instr = 16'b0100_1010_1011_1100;
        #10;

        // LW R13, 0(R14) (Load word from memory address in R14 to R13)
        instr = 16'b0101_1101_1110_0000;
        mem_data = 16'hABCD; // Simulated memory data
        #10;

        // SW R15, 0(R0) (Store word from R15 to memory address in R0)
        instr = 16'b0110_1111_0000_0000;
        #10;

        // NOP
        instr = 16'b0000_0000_0000_0000;
        #10;

        // End simulation
        #20;
        $finish;
    end

    // Monitor for outputs
    initial begin
        $monitor("Time=%0t, PC=%h, Instr=%h, ALU_Out=%h, MemRead=%b, MemWrite=%b",
                 $time, pc, instr, alu_out, mem_read, mem_write);
    end

    // Optional: Uncomment for waveform dump
    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, CPU_tb);
    end
endmodule
 

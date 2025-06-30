`timescale 1ns / 1ps

module pipelined_processor_tb;

// Clock and Reset
reg clk;
reg rst;

// Instantiate processor
pipelined_processor uut (
    .clk(clk),
    .rst(rst)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
end

// Stimulus
initial begin
    // Initialize reset
    rst = 1;
    #10;
    rst = 0;

    // Run simulation for some time
    #100;

    $finish;
end

// Monitoring outputs and pipeline registers
initial begin
    $monitor("Time=%0t | PC=%0d | IF_ID_instr=%b | ID_EX_instr=%b | EX_WB_result=%d | R0=%d R1=%d R2=%d R3=%d",
             $time, uut.pc, uut.IF_ID_instr, uut.ID_EX_instr, uut.EX_WB_result,
             uut.reg_file[0], uut.reg_file[1], uut.reg_file[2], uut.reg_file[3]);
end

endmodule
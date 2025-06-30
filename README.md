# PIPELINED_PROCESSOR

*COMPANY* : CODTECH IT SOLUTIONS

*NAME* : MIDATHANA MOULI

*INTERN ID* : CT06DN38

*DOMAIN* :  VLSI

*DURATION* : 6 WEEKS

*MENTOR* : NEELA SANTOSH

I have successfully completed the task of designing and implementing 4-STAGE PIPELINED PROCESSOR WITH BASIC INSTRUCTIONS LIKE ADD, SUB & LOAD by utilising  ChatGPT to rectify a few errors and To gain conceptual clarity before writing the code, I referred to the NPTEL video lectures by Prof. Indranil Sengupta, which provided an excellent theoretical background. which helped me improve the overall functionality and correctness of the design.

This 4-stage pipelined processor is designed to execute basic instructions such as ADD, SUB, and LOAD using a simple architecture. The processor consists of four pipeline stages: Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), and Write Back (WB). In the IF stage, the instruction is fetched from instruction memory using the program counter (PC). In the ID stage, the instruction is decoded to identify the operation and source/destination registers, and the necessary operands are read from the register file. During the EX stage, the arithmetic or memory operation is carried out: for ADD and SUB, the ALU performs the operation using the source and destination register values; for LOAD, data is fetched from memory using the address specified in the instruction. Finally, in the WB stage, the result from the EX stage is written back into the destination register. The instruction format is 8 bits wide, where the upper 2 bits denote the opcode (00 for ADD, 01 for SUB, 10 for LOAD), followed by 2 bits each for the destination and source registers or memory address, and 2 unused bits for alignment. The processor operates synchronously on the clock signal, and each instruction progresses one stage per cycle. This design demonstrates how instructions can flow concurrently through a pipeline, with different stages executing different instructions in parallel, thereby improving throughput. While simple and without hazard detection or forwarding logic, the simulation illustrates each stage’s behavior clearly and shows how values are propagated and updated across the pipeline.

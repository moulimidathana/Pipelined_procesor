`timescale 1ns / 1ps
module pipelined_processor (
    input clk,
    input rst
);

// OPCODES
localparam ADD  = 2'b00;
localparam SUB  = 2'b01;
localparam LOAD = 2'b10;

// Registers and Memory
reg [7:0] instr_mem [0:15];  // Instruction memory
reg [7:0] data_mem  [0:15];  // Data memory
reg [7:0] reg_file  [0:3];   // 4 registers R0-R3

//Pipeline Registers
reg [7:0] IF_ID_instr;

reg [7:0] ID_EX_instr;
reg [1:0] ID_EX_opcode;
reg [7:0] ID_EX_op1, ID_EX_op2;
reg [1:0] ID_EX_rd;

reg [7:0] EX_WB_result;
reg [1:0] EX_WB_rd;
reg       EX_WB_write;

// Program Counter
reg [3:0] pc;

//Instruction Fetch (IF)
always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= 0;
        IF_ID_instr <= 0;
    end else begin
        IF_ID_instr <= instr_mem[pc];
        pc <= pc + 1;
    end
end

//Instruction Decode (ID)
  wire [1:0] opcode = IF_ID_instr[7:6];
wire [1:0] rd     = IF_ID_instr[5:4];
wire [1:0] rs     = IF_ID_instr[3:2];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        ID_EX_instr  <= 0;
        ID_EX_opcode <= 0;
        ID_EX_op1    <= 0;
        ID_EX_op2    <= 0;
        ID_EX_rd     <= 0;
    end else begin
        ID_EX_instr  <= IF_ID_instr;
        ID_EX_opcode <= opcode;
        ID_EX_rd     <= rd;
        ID_EX_op1    <= reg_file[rd];                      // Destination register value
        ID_EX_op2    <= (opcode == LOAD) ? rs : reg_file[rs]; // Immediate address for LOAD or reg value
    end
end

//Execute (EX)
reg [7:0] alu_result;
reg       write_back;

always @(*) begin
    write_back = 1'b1;
    case (ID_EX_opcode)  // Use ID_EX_opcode (latched opcode)
        ADD:  alu_result = ID_EX_op1 + ID_EX_op2;
        SUB:  alu_result = ID_EX_op1 - ID_EX_op2;
        LOAD: alu_result = data_mem[ID_EX_op2];  // rs as address
        default: begin
            alu_result = 8'b0;
            write_back = 1'b0;
        end
    endcase
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        EX_WB_result <= 0;
        EX_WB_rd <= 0;
        EX_WB_write <= 0;
    end else begin
        EX_WB_result <= alu_result;
        EX_WB_rd <= ID_EX_rd;
        EX_WB_write <= write_back;
    end
end

// Write Back (WB) 
always @(posedge clk or posedge rst) begin
    if (rst) begin
        reg_file[0] <= 0;
        reg_file[1] <= 0;
        reg_file[2] <= 0;
        reg_file[3] <= 0;
    end else if (EX_WB_write) begin
        reg_file[EX_WB_rd] <= EX_WB_result;
    end
end

//Initialize Memories
  integer i;
initial begin
    for (i = 0; i < 16; i = i + 1) begin
        instr_mem[i] = 8'b0;
        data_mem[i] = i * 2; // Even numbers
    end

    // Sample Program
    instr_mem[0] = 8'b00000100; // ADD R0, R1
    instr_mem[1] = 8'b01101100; // SUB R2, R3
    instr_mem[2] = 8'b10010010; // LOAD R1, addr 2
end

endmodule

module InstructionMemory(
    input [31:0] PC,         // Program Counter input
    output [31:0] Instr      // Instruction output
);

    reg [31:0] memory [0:255]; // Define a memory with 256 32-bit locations

    // Instruction Fetch based on PC
    assign Instr = memory[PC >> 2]; // Fetch the instruction at the PC address (word aligned)

    // Initialize memory 
    initial begin
       $readmemh("D:/vivado/pipeline_Riscv/program.txt",memory);
    end
    /*initial
     begin 
     memory[0] = 32'h 00500113;
     memory[1] = 32'h 00C00193;
     memory[2] = 32'h FF718393;
     memory[3] = 32'h 0023E233;
     memory[4] = 32'h 0041F2B3;
     memory[5] = 32'h 004282B3;
     memory[6] = 32'h 02728863;
     memory[7] = 32'h 0041A233;
     memory[8] = 32'h 00020463;
     memory[9] = 32'h 00000293;
     memory[10] =32'h 0023A233;
     memory[11] =32'h 005203B3;
     memory[12] =32'h 402383B3;
     memory[13] =32'h 0471AA23 ;
     memory[14] =32'h 06002103 ;
     memory[15] =32'h 005104B3;
     memory[16] =32'h 008001EF;
     memory[17] =32'h 00100113;
     memory[18] =32'h 00910133;
    //$readmemh("memf 0221A023ile.txt",memory); 
    end*/
endmodule
 
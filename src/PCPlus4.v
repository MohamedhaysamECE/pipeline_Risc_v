module PCPlus4(
    input [31:0] PC,          // Current Program Counter
    output [31:0] PCPlus4     // PC incremented by 4 (for the next instruction)
);

    assign PCPlus4 = PC + 4;   // Add 4 to PC

endmodule

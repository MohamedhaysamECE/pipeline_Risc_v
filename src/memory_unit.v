`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 03:01:35 PM
// Design Name: 
// Module Name: memory_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module memory_unit(
    input [31:0]ALUResultM,WriteDataM,
    input clk,MemWriteM,
    output [31:0]ReadDataM
    );
    
     DataMemory mem2(.clk(clk), .MemWrite(MemWriteM), .WriteData(WriteDataM), .ALUResult(ALUResultM),
      .ReadData(ReadDataM));

endmodule

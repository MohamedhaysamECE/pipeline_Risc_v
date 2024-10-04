`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 06:01:46 PM
// Design Name: 
// Module Name: EM_pipeline_reg
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


module EM_pipeline_reg(
    input clk,RegWriteE,MemWriteE,                  
    input [1:0] ResultSrcE,                     
    input [31:0] ALUResultE,WriteDataE,PCPlus4E,
    input [4:0] RdE,                                 
    output reg RegWriteM,MemWriteM,
    output reg [1:0] ResultSrcM,
    output reg [31:0] ALUResultM,WriteDataM,PCPlus4M,
    output reg [4:0] RdM
    );
     always @(posedge clk)
           begin
               RegWriteM <= RegWriteE;
               ResultSrcM <= ResultSrcE;
               MemWriteM <= MemWriteE;
               ALUResultM <= ALUResultE;
               WriteDataM <= WriteDataE;
               RdM <= RdE;
               PCPlus4M <= PCPlus4E;
           end 
endmodule

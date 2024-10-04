`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 06:01:46 PM
// Design Name: 
// Module Name: MW_pipeline_reg
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


module MW_pipeline_reg(
    input clk,RegWriteM,                            
    input [1:0]ResultSrcM,                      
    input [31:0] ReadDataM,ALUResultM,PCPlus4M, 
    input [4:0] RdM,                                 
    output reg RegWriteW,
    output reg [1:0]ResultSrcW,
    output reg [31:0] ReadDataW,ALUResultW,PCPlus4W,
    output reg [4:0] RdW
    );
      always @(posedge clk)
      begin
           ReadDataW <= ReadDataM;
           ALUResultW <= ALUResultM;
           RdW <= RdM;
           PCPlus4W <= PCPlus4M;
           RegWriteW <= RegWriteM;
           ResultSrcW <= ResultSrcM;
      end
endmodule

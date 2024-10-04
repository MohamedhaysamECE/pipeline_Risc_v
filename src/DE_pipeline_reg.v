`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 06:01:46 PM
// Design Name: 
// Module Name: DE_pipeline_reg
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


module DE_pipeline_reg(
    input FlushE,clk,MemWriteD,ALUsrcD,RegWriteD,BranchD,JumpD,
    input [2:0] ALUControlD,                        
    input [1:0] ResultSrcD,                         
    input [31:0] RD1,RD2,PCD,ImmExtD,PCPlus4D,Instr,                                  
    output reg MemWriteE,ALUsrcE,RegWriteE,BranchE,JumpE,
    output reg [2:0] ALUControlE,
    output reg [1:0] ResultSrcE,
    output reg [31:0] RD1E,RD2E,PCE,ImmExtE,PCPlus4E,
    output reg [4:0]Rs1E,Rs2E,RdE
    );
    
 wire [4:0] Rs1D,Rs2D,RdD;   
 assign Rs1D = Instr[19:15];
 assign Rs2D = Instr[24:20];
 assign RdD = Instr[11:7];
     always @(posedge clk)
           begin
               if(FlushE)
                   begin
                       MemWriteE <= 0;
                        ALUsrcE <= 0;
                        RegWriteE <= 0;
                        BranchE <= 0;
                        JumpE <= 0;
                        ALUControlE <= 0;
                        ResultSrcE <= 0;  
                        RD1E <= 0;
                        RD2E <= 0;
                        PCE <= 0;  
                        Rs1E <= 0;
                        Rs2E <= 0;
                        RdE <= 0;   
                        ImmExtE <= 0;  
                        PCPlus4E <= 0;     
                   end
                else
                   begin
                        MemWriteE <= MemWriteD;     
                        ALUsrcE <= ALUsrcD;         
                        RegWriteE <= RegWriteD;     
                        BranchE <= BranchD;         
                        JumpE <= JumpD;             
                        ALUControlE <= ALUControlD; 
                        ResultSrcE <= ResultSrcD;
                        RD1E <= RD1;
                        RD2E <= RD2;
                        PCE <= PCD;  
                        Rs1E <= Rs1D;
                        Rs2E <= Rs2D;
                        RdE <= RdD;
                        ImmExtE <= ImmExtD;
                        PCPlus4E <= PCPlus4D;
                   end   
           end
endmodule

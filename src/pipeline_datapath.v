`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 09:01:49 AM
// Design Name: 
// Module Name: pipeline_Top_module
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


module pipeline_datapath(
    input clk,FlushD,StallD,
    input StallF,FlushE,
    input [1:0]ForwardAE,ForwardBE,
    output [4:0] Rs1D,Rs2D,
    output  [4:0] Rs1E,Rs2E,RdE,RdM,RdW,
    output  [1:0] ResultSrcE,
    output PCSrcE,
    output  RegWriteM,RegWriteW,
    output [31:0]dataadr, WriteData  
    );
    
    
    wire [1:0]ResultSrcD;
    wire MemWriteD,ALUsrcD,RegWriteD,BranchD,JumpD;
    wire [2:0]ALUControlD;
    wire MemWriteE,MemWriteM,ALUsrcE,RegWriteE,BranchE,JumpE;
    wire [1:0]ResultSrcM,ResultSrcW;
    wire [2:0]ALUControlE;
    wire [31:0]RD1E,RD2E,PCE,ImmExtE,WriteDataM,ALUResultM,ALUResultW,ReadDataW;
    wire [31:0]ResultW,RD1,RD2,ImmExtD,ALUResultE;
    wire [4:0]RdD;
    wire [31:0] PCTargetE,Instr,PC,PCPlus4,WriteDataE,ReadDataM;
    wire [31:0] InstrD,PCD,PCPlus4D,PCPlus4E,PCPlus4M,PCPlus4W;
    
  
assign Rs1D = InstrD[19:15];
assign Rs2D = InstrD[24:20];
 ///////////////////// Fetch_unit //////////////////////////////////////////   
    Fetch_unit U1( .clk(clk), .StallF(StallF), .pcsrc(PCSrcE), .PCtarget(PCTargetE),.Instr(Instr),.PC(PC),
    .PCPlus4(PCPlus4) );
    
 ///////////////////// Fetch/Decode pipeline register/////////////////////
   FD_pipeline_reg f1( .FlushD(FlushD),.clk(clk),.StallD(StallD),.Instr(Instr),.PC(PC),.PCPlus4(PCPlus4),.InstrD(InstrD),.PCD(PCD),.PCPlus4D(PCPlus4D) );
   
   
   /////////////////////// Decode unit ///////////////
    Decode_unit U2(.Instr(InstrD),.clk(clk), .RegWriteW(RegWriteW),.ResultW(ResultW),.RDW(RdW),.ResultSrc(ResultSrcD), .MemWrite(MemWriteD)
    ,.ALUsrc(ALUsrcD), .RegWriteD(RegWriteD),.ALU_control(ALUControlD),.Branch(BranchD), .Jump(JumpD), .RD1(RD1),.RD2(RD2),.ImmExtD(ImmExtD) );
    
    
    /////////////////////decode/excute pipeline register///////////////////////
   DE_pipeline_reg f2(.FlushE(FlushE),.clk(clk),.MemWriteD(MemWriteD),.ALUsrcD(ALUsrcD),.RegWriteD(RegWriteD),.BranchD(BranchD),.JumpD(JumpD), .ALUControlD(ALUControlD),                        
         .ResultSrcD(ResultSrcD), .RD1(RD1),.RD2(RD2),.PCD(PCD),.ImmExtD(ImmExtD),.PCPlus4D(PCPlus4D),.Instr(InstrD),                              
        .MemWriteE(MemWriteE),.ALUsrcE(ALUsrcE),.RegWriteE(RegWriteE),.BranchE(BranchE),.JumpE(JumpE),.ALUControlE(ALUControlE),.ResultSrcE(ResultSrcE),.RD1E(RD1E),.RD2E(RD2E),.PCE(PCE),.ImmExtE(ImmExtE),.PCPlus4E(PCPlus4E),.Rs1E(Rs1E),.Rs2E(Rs2E),.RdE(RdE)
        );
        
    ///////////////////excute unit /////////////////////////////////////////////
    Excute_unit U3(.ALUControlE(ALUControlE), .RD1E(RD1E),.RD2E(RD2E),.ResultW(ResultW),.ALUResultM(ALUResultM),.PCE(PCE),.ForwardA(ForwardAE),.ForwardB(ForwardBE),
                   .BranchE(BranchE),.JumpE(JumpE),.ALUsrcE(ALUsrcE),.ImmExtE(ImmExtE), .PCsrc(PCSrcE),.ALUResult(ALUResultE),.WriteDataE(WriteDataE),.PCTarget(PCTargetE)
                  );
                  
                  
   ////////////////////Excute/memory pipeline register /////////////////////////
  EM_pipeline_reg f3( .clk(clk),.RegWriteE(RegWriteE),.MemWriteE(MemWriteE),.ResultSrcE(ResultSrcE),.ALUResultE(ALUResultE),.WriteDataE(WriteDataE),.PCPlus4E(PCPlus4E),
                     .RdE(RdE), .RegWriteM(RegWriteM),.MemWriteM(MemWriteM), .ResultSrcM(ResultSrcM),.ALUResultM(ALUResultM),.WriteDataM(WriteDataM),.PCPlus4M(PCPlus4M),.RdM(RdM));
                     
                     
  ///////////////////////memory unit ////////////////////////////////////////////
  memory_unit U4(.ALUResultM(ALUResultM),.WriteDataM(WriteDataM), .clk(clk),.MemWriteM(MemWriteM),.ReadDataM(ReadDataM) );
  
  ///////////////////////memory/writeback pipeline register///////////////////////
 MW_pipeline_reg f4(.clk(clk),.RegWriteM(RegWriteM),.ResultSrcM(ResultSrcM),.ReadDataM(ReadDataM),.ALUResultM(ALUResultM),.PCPlus4M(PCPlus4M), 
                    .RdM(RdM),.RegWriteW(RegWriteW),.ResultSrcW(ResultSrcW),.ReadDataW(ReadDataW),.ALUResultW(ALUResultW),.PCPlus4W(PCPlus4W),.RdW(RdW)
                     );
    
    
    ///////////////////writeback unit///////////////////////////////////////////
Writeback_unit U5(.ReadDataW(ReadDataW),.ALUResultW(ALUResultW),.PCPlus4W(PCPlus4W),.ResultSrcW(ResultSrcW), .ResultW(ResultW));

assign dataadr = ALUResultM;
assign WriteData = WriteDataM;   

endmodule

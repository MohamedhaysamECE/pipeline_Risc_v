`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 03:01:35 PM
// Design Name: 
// Module Name: Excute_unit
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


module Excute_unit(
    input [2:0]ALUControlE,
    input [31:0]RD1E,RD2E,ResultW,
    input [31:0]ALUResultM,PCE,
    input [1:0]ForwardA,ForwardB,
    input BranchE,JumpE,ALUsrcE,
    input [31:0] ImmExtE,
    output reg PCsrc,
    output [31:0]ALUResult,WriteDataE,PCTarget
    );
    
    wire [31:0]SrcAE,SrcBE;
    wire ZeroFlag;
always @(*)  
    begin 
        if(((ZeroFlag == 1) && (BranchE ==1))|| (JumpE == 1))
            PCsrc = 1;
        else
            PCsrc = 0;    
    end  

     
      mux3 M3(.s(ForwardA), .A(RD1E), .B(ResultW), .C(ALUResultM), .Y(SrcAE));

      mux3 M4(.s(ForwardB), .A(RD2E), .B(ResultW), .C(ALUResultM), .Y(WriteDataE));
      
      mux2 M2(.s(ALUsrcE), .A(WriteDataE), .B(ImmExtE), .Y(SrcBE));
      
      alu A1(.SrcA(SrcAE), .SrcB(SrcBE), .ALUControl(ALUControlE),
       .ALUResult(ALUResult), .Zero(ZeroFlag));
       
      adder A3( .a(PCE), .b(ImmExtE), .y(PCTarget));

initial PCsrc = 0;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 03:01:35 PM
// Design Name: 
// Module Name: Decode_unit
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


module Decode_unit(
    input [31:0]Instr,
    input clk, RegWriteW,
    input [31:0]ResultW,
    input [4:0]RDW,
    output [1:0]ResultSrc,
    output MemWrite,
    output ALUsrc,
    output RegWriteD,
    output [2:0]ALU_control,
    output Branch, Jump,
    output [31:0] RD1,RD2,ImmExtD
        );
    wire [1:0]ImmSrc;
     
   control_unit_p c1(.op(Instr[6:0]), .funct3(Instr[14:12]), .funct7(Instr[30]),.Branch(Branch), .Jump(Jump),
     .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUsrc(ALUsrc), .ImmSrc(ImmSrc), .RegWrite(RegWriteD), .ALU_control(ALU_control));

     register_file_p reg1(.clk(clk), .WE3(RegWriteW), .A1(Instr[19:15]),.A2(Instr[24:20]),.A3(RDW),
      .WD3(ResultW), .RD1(RD1), .RD2(RD2));
      
     extend E1(.instr(Instr), .ImmScr(ImmSrc), .ImmExt(ImmExtD));

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 03:01:35 PM
// Design Name: 
// Module Name: Writeback_unit
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


module Writeback_unit(
    input [31:0]ReadDataW,ALUResultW,PCPlus4W,
    input [1:0]ResultSrcW,
    output [31:0]ResultW
    );
    
    mux3 M3(.s(ResultSrcW), .A(ALUResultW), .B(ReadDataW), .C(PCPlus4W), .Y(ResultW));

endmodule

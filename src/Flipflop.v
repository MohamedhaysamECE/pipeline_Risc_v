`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 09:20:44 AM
// Design Name: 
// Module Name: Flipflop
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


module Flipflop(
        input clk,StallF,                // Clock input
        input [31:0] PCNext,      // Next Program Counter value
        output reg [31:0] PC      // Current Program Counter value
    );
    
        always @(posedge clk) begin
            if (StallF)
                PC <= PC;       // Reset the PC to 0 on reset signal
            else
                PC <= PCNext;      // Update PC to the next value on clock edge
        end
         initial
         PC = 32'd0;
endmodule

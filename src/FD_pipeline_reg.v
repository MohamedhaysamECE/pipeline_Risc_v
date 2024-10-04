`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2024 06:01:46 PM
// Design Name: 
// Module Name: FD_pipeline_reg
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


module FD_pipeline_reg(
    input FlushD,clk,StallD,
    input [31:0]Instr,PC,PCPlus4,
    output reg [31:0]InstrD,PCD,PCPlus4D
    );
   always @(posedge clk)
     begin
         if(FlushD)
             begin 
             InstrD <= 0;
             PCD <= 0;
             PCPlus4D <= 0; 
             end
          else
             if(StallD)
                 begin
                      InstrD <= InstrD;
                      PCD <= PCD;
                      PCPlus4D <= PCPlus4D;   
                 end   
              else   
                 begin
                         InstrD <= Instr;
                         PCD <= PC;
                         PCPlus4D <= PCPlus4; 
                 end          
     end  
endmodule

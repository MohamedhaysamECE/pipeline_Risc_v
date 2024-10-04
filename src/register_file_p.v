`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 03:21:51 PM
// Design Name: 
// Module Name: register_file_p
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


module register_file_p(

        input clk,                   // Clock signal
        input [4:0] A1, A2, A3,      // Register addresses
        input [31:0] WD3,            // Write data
        input WE3,                   // Write enable
        output   [31:0] RD1, RD2   // Read data
    );
    
        // Register file (32 registers of 32 bits)
        reg [31:0] registers [31:0];
    
    
        // Write port
        always @(negedge clk) begin
            if (WE3) begin
                registers[A3] <= WD3; // Write WD3 to register A3 on clock edge
            end
        end
         // Read ports
         /*always @(posedge clk)
           begin
              RD1 <= (A1 != 0)? registers[A1] : 32'd0;
              RD2 <= (A2 != 0)? registers[A2] : 32'd0;
           end*/
    assign   RD1 = (A1 != 0)? registers[A1] : 32'd0;
    assign   RD2 = (A2 != 0)? registers[A2] : 32'd0;
    
endmodule

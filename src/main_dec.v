module main_dec(
 input [6:0]op,
 output reg branch,
 output reg [1:0]ResultSrc,
 output reg MemWrite,
 output reg ALUsrc,
 output reg [1:0]ImmSrc,
 output reg RegWrite,
 output reg [1:0]ALUop,
 output reg Jump 
 );
 always @(*)
  begin
   casex(op)
    7'b0000011: {RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,branch,ALUop,Jump} = 11'b10010010000; // LW instruction
    7'b0100011: {RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,branch,ALUop,Jump} = 11'b00111xx0000; // SW instruction
    7'b0110011: {RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,branch,ALUop,Jump} = 11'b1xx00000100; // R-type instruction
    7'b1100011: {RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,branch,ALUop,Jump} = 11'b01000xx1010; // beq instruction
    7'b0010011: {RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,branch,ALUop,Jump} = 11'b10010000100; // I-tyrpeinstruction
    7'b1101111: {RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,branch,ALUop,Jump} = 11'b111x0100xx1; // J-type instruction
    default: {RegWrite,ImmSrc,ALUsrc,MemWrite,ResultSrc,branch,ALUop,Jump} = 11'bxxxxxxxxxxx;
   endcase
  end


endmodule
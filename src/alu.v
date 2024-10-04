module alu (
    input [31:0] SrcA, SrcB,   // ALU inputs
    input [2:0] ALUControl,    // ALU control signals
    output reg [31:0] ALUResult, // ALU output
    output Zero               // Zero flag
);
    // ALU operation
    always @(*) begin
        case(ALUControl)
            3'b000: ALUResult = SrcA + SrcB;  // Add
            3'b001: ALUResult = SrcA - SrcB;  // Subtract
            3'b010: ALUResult = SrcA & SrcB;  // AND
            3'b011: ALUResult = SrcA | SrcB;  // OR
            3'b101: ALUResult = (SrcA < SrcB) ? 1 : 0; // SLT
            default: ALUResult = 32'hXXXXXXXX; // Undefined operation
        endcase
    end

    // Zero flag
    assign Zero = (ALUResult == 0);
endmodule

module tb_alu;
    reg [31:0] SrcA, SrcB;
    reg [2:0] ALUControl;
    wire [31:0] ALUResult;
    wire Zero;

    // Instantiate ALU
    alu uut (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    initial begin
        // Test case 1: Add
        SrcA = 32'h00000005; SrcB = 32'h00000003; ALUControl = 3'b000;
        #10;
        
        // Test case 2: Subtract
        ALUControl = 3'b001;
        #10;
        
        // Test case 3: AND
        ALUControl = 3'b010;
        #10;

        // Test case 4: OR
        ALUControl = 3'b011;
        #10;

        // End simulation
        $finish;
    end
endmodule

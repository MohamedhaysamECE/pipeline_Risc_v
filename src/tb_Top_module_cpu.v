module tb_Top_module_cpu;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] Instr;
    reg [31:0] ReadData;

    // Outputs
    wire [31:0] PC;
    wire [31:0] ALU_result;
    wire [31:0] WriteData;
    wire Zero_flag;

    // Instantiate the Unit Under Test (UUT)
    Top_module_cpu uut (
        .clk(clk),
        .reset(reset),
        .Instr(Instr),
        .ReadData(ReadData),
        .PC(PC),
        .ALU_result(ALU_result),
        .WriteData(WriteData),
        .Zero_flag(Zero_flag)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        Instr = 32'b0;
        ReadData = 32'b0;

        // Apply reset
        #10 reset = 0;

        // Apply test cases
        Instr = 32'h00000013; // Example instruction
        ReadData = 32'h00000000; // Example data
        #20;
        
        Instr = 32'h00000000; // Another instruction
        #20;

        
        #100;
        $finish;
    end

endmodule


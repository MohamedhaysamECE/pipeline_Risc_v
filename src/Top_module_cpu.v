module Top_module_cpu(
    input clk,
    input reset
);

    // Wires for connections
    wire [31:0] PC, Instr, PCPlus4, ALUResult, WriteData, ReadData, ImmExt, Result;
    wire [2:0] ALU_control;
    wire [1:0] ResultSrc, ImmSrc;
    wire RegWrite, ALUsrc, MemWrite, Branch, Jump, Zero_flag, PCsrc, StallF, StallD, FlushD, FlushE;

    // Instantiate Fetch Unit
    Fetch_unit fetch_unit (
        .clk(clk),
        .pcsrc(PCsrc),
        .StallF(StallF),
        .PCtarget(ImmExt), // Assumes PCtarget is the immediate extended value
        .Instr(Instr),
        .PC(PC),
        .PCPlus4(PCPlus4)
    );

    // Instantiate Decode Unit
    Decode_unit decode_unit (
        .Instr(Instr),
        .clk(clk),
        .RegWriteW(RegWrite),
        .ResultW(Result),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUsrc(ALUsrc),
        .RegWriteD(RegWrite),
        .ALU_control(ALU_control),
        .Branch(Branch),
        .Jump(Jump),
        .RD1(ReadData),  // RD1 and RD2 are used for reading data from register file
        .RD2(WriteData),
        .ImmExtD(ImmExt)
    );

    // Instantiate Execute Unit
    Excute_unit execute_unit (
        .ALUControlE(ALU_control),
        .RD1E(ReadData),
        .RD2E(WriteData),
        .ResultW(Result),
        .ALUResultM(ALUResult),
        .PCE(PC),
        .ForwardA(2'b00), // Assume no forwarding for simplicity
        .ForwardB(2'b00),
        .BranchE(Branch),
        .JumpE(Jump),
        .ALUsrcE(ALUsrc),
        .ImmExtE(ImmExt),
        .PCsrc(PCsrc),
        .ALUResult(ALUResult),
        .WriteDataE(WriteData),
        .PCTarget(PCPlus4) // Assume PCTarget is the next PC
    );

    // Instantiate Memory Unit
    memory_unit mem_unit (
        .ALUResultM(ALUResult),
        .WriteDataM(WriteData),
        .clk(clk),
        .MemWriteM(MemWrite),
        .ReadDataM(ReadData)
    );

    // Instantiate Write-back pipeline register
    MW_pipeline_reg mw_pipeline_reg (
        .clk(clk),
        .RegWriteM(RegWrite),
        .ResultSrcM(ResultSrc),
        .ReadDataM(ReadData),
        .ALUResultM(ALUResult),
        .PCPlus4M(PCPlus4),
        .RdM(Instr[11:7]), // Assume destination register is part of instruction
        .RegWriteW(RegWrite),
        .ResultSrcW(ResultSrc),
        .ReadDataW(ReadData),
        .ALUResultW(ALUResult),
        .PCPlus4W(PCPlus4),
        .RdW(Instr[11:7])
    );

    // Instantiate Hazard Detection Unit
    hazard_detection_unit hazard_detection (
        .rs1(Instr[19:15]),
        .rs2(Instr[24:20]),
        .rd_ex(Instr[11:7]),
        .mem_read_ex(MemWrite),
        .stall(StallF) // Signal to stall Fetch Unit
    );

    // Instantiate Decode-Execute Pipeline Register
    DE_pipeline_reg de_pipeline_reg (
        .FlushE(FlushE),
        .clk(clk),
        .MemWriteD(MemWrite),
        .ALUsrcD(ALUsrc),
        .RegWriteD(RegWrite),
        .BranchD(Branch),
        .JumpD(Jump),
        .ALUControlD(ALU_control),
        .ResultSrcD(ResultSrc),
        .RD1(ReadData),
        .RD2(WriteData),
        .PCD(PC),
        .ImmExtD(ImmExt),
        .PCPlus4D(PCPlus4),
        .Instr(Instr),
        .MemWriteE(MemWrite),
        .ALUsrcE(ALUsrc),
        .RegWriteE(RegWrite),
        .BranchE(Branch),
        .JumpE(Jump),
        .ALUControlE(ALU_control),
        .ResultSrcE(ResultSrc),
        .RD1E(ReadData),
        .RD2E(WriteData),
        .PCE(PC),
        .ImmExtE(ImmExt),
        .PCPlus4E(PCPlus4),
        .Rs1E(Instr[19:15]),
        .Rs2E(Instr[24:20]),
        .RdE(Instr[11:7])
    );
endmodule


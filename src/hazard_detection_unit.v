module hazard_detection_unit (
    input [4:0] rs1, rs2,       // Source registers from the instruction
    input [4:0] rd_ex,          // Destination register in EX stage
    input mem_read_ex,          // Memory read signal in EX stage
    output reg stall            // Output stall signal
);

    always @(*) begin
        // If the instruction in EX stage is reading from memory (load) and the destination register is being used by the current instruction
        if (mem_read_ex && ((rd_ex == rs1) || (rd_ex == rs2))) begin
            stall = 1'b1;  // Stall the pipeline
        end else begin
            stall = 1'b0;  // No stall needed
        end
    end
endmodule

module tb_hazard_detection_unit;
    reg [4:0] rs1, rs2, rd_ex;
    reg mem_read_ex;
    wire stall;

    // Instantiate the hazard detection unit
    hazard_detection_unit hdu (
        .rs1(rs1),
        .rs2(rs2),
        .rd_ex(rd_ex),
        .mem_read_ex(mem_read_ex),
        .stall(stall)
    );

    initial begin
        // Test case 1: No hazard (no stall)
        rs1 = 5'd1; rs2 = 5'd2; rd_ex = 5'd3; mem_read_ex = 1'b0;
        #10;
        $display("Test 1: Stall = %b", stall); // Expect 0

        // Test case 2: Hazard (stall)
        rs1 = 5'd1; rs2 = 5'd2; rd_ex = 5'd1; mem_read_ex = 1'b1;
        #10;
        $display("Test 2: Stall = %b", stall); // Expect 1

        // Test case 3: No hazard (no stall)
        rs1 = 5'd4; rs2 = 5'd5; rd_ex = 5'd3; mem_read_ex = 1'b1;
        #10;
        $display("Test 3: Stall = %b", stall); // Expect 0

        // Test case 4: Hazard (stall)
        rs1 = 5'd1; rs2 = 5'd2; rd_ex = 5'd2; mem_read_ex = 1'b1;
        #10;
        $display("Test 4: Stall = %b", stall); // Expect 1

        $finish;
    end
endmodule


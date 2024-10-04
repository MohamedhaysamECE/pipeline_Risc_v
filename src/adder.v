module adder (
    input [31:0] a, b,   // Adder inputs
    output [31:0] y      // Adder result
);
    // Adder logic
    assign y = a + b;
endmodule

module tb_adder;
    reg [31:0] a, b;
    wire [31:0] y;

    // Instantiate adder
    adder uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Test case 1: Add two numbers
        a = 32'h00000003; b = 32'h00000004;
        #10;

        // Test case 2: Add two different numbers
        a = 32'hFFFFFFFF; b = 32'h00000001;
        #10;

        // End simulation
        $finish;
    end
endmodule

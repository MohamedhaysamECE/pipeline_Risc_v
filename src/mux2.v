module mux2 #(parameter WIDTH = 32) (
    input wire [WIDTH-1:0] A, 
    input wire [WIDTH-1:0] B,
    input wire s,
    output wire [WIDTH-1:0] Y
);
    assign Y = s ? B : A;
endmodule

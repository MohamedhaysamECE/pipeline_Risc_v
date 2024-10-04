module mux3 #(parameter WIDTH = 32) (
    input wire [WIDTH-1:0] A, 
    input wire [WIDTH-1:0] B, 
    input wire [WIDTH-1:0] C,
    input wire [1:0] s,
    output wire [WIDTH-1:0] Y
);
    assign Y = s[1] ? C : (s[0] ? B : A);
endmodule


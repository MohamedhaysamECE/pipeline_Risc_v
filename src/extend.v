module extend (
    input [31:0] instr,           // Input instruction
    input [1:0]ImmScr,
    output reg [31:0] ImmExt       // Output extended immediate
);
    // Sign-extend the immediate field
    always @(*) begin

    case(ImmScr)
     2'b00: ImmExt = {{20{instr[31]}},instr[31:20]};                            // LW   
     2'b01: ImmExt = {{20{instr[31]}},instr[31:25],instr[11:7]};                  // SW 
     2'b10: ImmExt = {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};    // branch 
     2'b11: ImmExt = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};  // Jump
     default: ImmExt = 32'bx;
    endcase
  
    end
endmodule

module tb_extend;
    reg [31:0] instr;
    reg [1:0]ImmScr;
    wire [31:0] ImmExt;

    // Instantiate extend
    extend uut (
        .instr(instr),
        .ImmScr(ImmScr),
        .ImmExt(ImmExt)
    );

    initial begin
         ImmScr = 2'b00;
        // Test case 1
        instr = 32'h00500113; // Sign extend a negative value
        #10;
        

        $finish;
    end
endmodule

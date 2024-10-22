
module ALU(Ain, Bin, ALUop, out, Z);

  input [15:0] Ain, Bin;   // Input operands
  input [1:0] ALUop;       // ALU control signals
  output [15:0] out;        // Output result
  output Z;                 // Zero flag

  reg [15:0] out;           // Output register
  reg Z;                    // Zero flag register

  always @(*) begin
    // ALU operation based on the ALU control signals
    case (ALUop)
      2'b00: out = Ain + Bin;  // Addition operation
      2'b01: out = Ain - Bin;  // Subtraction operation
      2'b10: out = Ain & Bin;  // Bitwise AND operation
      2'b11: out = ~Bin;       // Bitwise NOT operation
    endcase

    // Setting the zero flag if the result is zero
    if (out == 16'b0)
      Z = 1;
    else 
      Z = 0;
  end

endmodule

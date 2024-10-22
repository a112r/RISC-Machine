
module shifter(in,shift,shift_out);

  input [15:0] in;       // Input data to be shifted
  input [1:0] shift;     // Control signals for shift operations
  output [15:0] shift_out;     // Output result after shifting
  reg [15:0] shift_out;        // Output register

  always @(*) begin
    // Shifting operation based on the control signals
    case (shift)
      2'b00: shift_out = in;                   // No shift, output is the same as input
      2'b01: {shift_out, shift_out[0]} = {in << 1, 1'b0}; // Left shift by 1 with zero fill
      2'b10: {shift_out, shift_out[15]} = {in >> 1, 1'b0}; // Right shift by 1 with zero fill
      2'b11: {shift_out} = {in[15], in[15:1]}; // Circular shift to the right
    endcase
  end

endmodule

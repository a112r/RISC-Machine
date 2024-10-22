

/*
module datapath(writenum, write, readnum, PC, sximm5, clk, loada, mdata, sximm8, loadb, shift, asel, bsel, ALUop, loadc, loads, vsel, datapath_out, status_out);
  input [15:0] mdata, sximm8, sximm5;
  input [8:0] PC;
  input [2:0] writenum, readnum;
  input write, clk, loada, loadb, loadc, loads,  asel, bsel;
  input [1:0] shift, ALUop, vsel;
  output [15:0] datapath_out;
  output [2:0] status_out;


  //middle wires
  wire [15:0] data_in, data_out, Atemp, Btemp, out, sout, Ain, Bin;
  wire Z, overflow;
  wire [2:0] status_in;
  
  //unit 1
  regfile REGFILE(data_in, writenum, write, readnum, clk, data_out);

  //unit 2
  ALU U2(Ain, Bin, ALUop, out, Z);

  //unit 3, 4, 5
  vDFFE #(16) A(data_out, loada, clk, Atemp);
  vDFFE #(16) B(data_out, loadb, clk, Btemp);
  vDFFE #(16) C(out, loadc, clk, datapath_out);

  //unit 6
  assign Ain = asel ? 16'b0 : Atemp;
  //unit 7
  assign Bin = bsel ? sximm5 : sout;

  //unit 8
  shifter U1(Btemp,shift,sout);

  //unit 9
  Mux4 #(16) U0(mdata, sximm8, {7'b0,PC}, datapath_out, vsel, data_in);

  //unit 10
  vDFFE #(3) stat(status_in, loads, clk, status_out);

  checkovf #(16) overflowcheck(Ain, Bin, ALUop, overflow);
  assign status_in = {overflow,out[15],Z};

  

endmodule*/




module datapath(writenum, write, readnum, PC, sximm5, clk, loada, mdata, sximm8, loadb, shift, asel, bsel, ALUop, loadc, loads, vsel, datapath_out, status_out);
  input [15:0] mdata, sximm8, sximm5; // Immediate values for memory and sign-extended values
  input [8:0] PC; // Program Counter
  input [2:0] writenum, readnum; // Register numbers for write and read operations
  input write, clk, loada, loadb, loadc, loads,  asel, bsel; // Control signals
  input [1:0] shift, ALUop, vsel; // Control signals for shift, ALU operation, and multiplexer selection
  output [15:0] datapath_out; // Output data from the datapath
  output [2:0] status_out; // Output status containing overflow, ALU output MSB, and zero flag

  // Middle wires
  wire [15:0] data_in, data_out, Atemp, Btemp, out, sout, Ain, Bin; // Internal signals
  wire Z, overflow; // Zero flag and overflow flag
  wire [2:0] status_in; // Status input to the status register

  // Unit 1: Register File
  regfile REGFILE(data_in, writenum, write, readnum, clk, data_out);

  // Unit 2: Arithmetic Logic Unit (ALU)
  ALU U2(Ain, Bin, ALUop, out, Z);

  // Units 3, 4, 5: Data Flip-Flop Elements for Register A, B, and Output
  vDFFE #(16) A(data_out, loada, clk, Atemp);
  vDFFE #(16) B(data_out, loadb, clk, Btemp);
  vDFFE #(16) C(out, loadc, clk, datapath_out);

  // Unit 6: Multiplexer for Input A
  assign Ain = asel ? 16'b0 : Atemp;

  // Unit 7: Multiplexer for Input B
  assign Bin = bsel ? sximm5 : sout;

  // Unit 8: Shifter
  shifter U1(Btemp, shift, sout);

  // Unit 9: Multiplexer for Data Input
  Mux4 #(16) U0(mdata, sximm8, {7'b0, PC}, datapath_out, vsel, data_in);

  // Unit 10: Status Register with Data Flip-Flop Element
  vDFFE #(3) stat(status_in, loads, clk, status_out);

  // Overflow Checker
  checkovf #(16) overflowcheck(Ain, Bin, ALUop, overflow);

  // Combining overflow, ALU output MSB, and zero flag into the status input
  assign status_in = {overflow, out[15], Z};
endmodule


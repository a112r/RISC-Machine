//try1.6

module regfile(data_in,writenum,write,readnum,clk,data_out);

  input [15:0] data_in;      // Input data to be written into the register file
  input [2:0] writenum, readnum; // Register numbers for write and read operations
  input write, clk;          // Control signals for write operation and clock signal
  output [15:0] data_out;     // Output data read from the register file

  wire [7:0] tempw, tempr, towrite; // Temporary wires for write and read operations
  wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7; // Individual registers

  // Decode where to write: Convert the write number to an 8-bit select signal
  Dec #(3, 8) top(writenum, tempw);
  // Determine which register(s) to write to based on the write control signal
  assign towrite = tempw & {8{write}};

  // Enable the load of the registers being written to
  vDFFE #(16) Rzero(data_in, towrite[0], clk, R0);
  vDFFE #(16) Rone(data_in, towrite[1], clk, R1);
  vDFFE #(16) Rtwo(data_in, towrite[2], clk, R2);
  vDFFE #(16) Rthree(data_in, towrite[3], clk, R3);
  vDFFE #(16) Rfour(data_in, towrite[4], clk, R4);
  vDFFE #(16) Rfive(data_in, towrite[5], clk, R5);
  vDFFE #(16) Rsix(data_in, towrite[6], clk, R6);
  vDFFE #(16) Rseven(data_in, towrite[7], clk, R7);

  // Decode where to read: Convert the read number to an 8-bit select signal
  Dec #(3, 8) bot(readnum, tempr);
  // Select the data to be read based on the read control signal
  Mux8 #(16) outp(R0, R1, R2, R3, R4, R5, R6, R7, tempr, data_out);

endmodule




module RAM(clk,read_address,write_address,write,din,dout);
  parameter data_width = 32; 
  parameter addr_width = 4;
  parameter filename = "data.txt";

  input clk;
  input [addr_width-1:0] read_address, write_address;
  input write;
  input [data_width-1:0] din;
  output [data_width-1:0] dout;
  reg [data_width-1:0] dout;

  reg [data_width-1:0] mem [2**addr_width-1:0];// Memory array with specified data and address widths
// Initializing memory content from an external file ("data.txt")
  initial $readmemb(filename, mem);

  always @ (posedge clk) begin// Write operation: If the write control signal is asserted, store the input data at the specified write address
    if (write)
      mem[write_address] <= din;// Read operation: Retrieve the data from the specified read address
    dout <= mem[read_address]; // Note: The use of non-blocking assignment ("<=") ensures that dout isn't updated in the same clock cycle as din
                               
  end 
endmodule


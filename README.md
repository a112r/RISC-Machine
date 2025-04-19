# 32-bit ARM CPU and Datapath Implementation

This project, done as a part of a course features a fully functional 32-bit CPU and datapath, developed using Verilog, capable of decoding and executing ARM Assembly instructions. The CPU design is implemented and tested on a **DE1-SoC FPGA**.

## Features

- **ARM Instruction Set Support**: The CPU decodes and executes ARM Assembly instructions, providing a complete implementation of the ARM instruction set.
- **32-bit CPU Architecture**: A robust 32-bit processor design, optimized for basic ARM operations.
- **Datapath Implementation**: The datapath is designed to support a wide variety of instructions and efficiently manage the flow of data throughout the processor.
- **FPGA Deployment**: Synthesized and implemented on the **DE1-SoC FPGA**, ensuring hardware compatibility and efficient performance.
  
## Development and Tools

- **SystemVerilog**: Used to design the CPU, ALU, regfile, shifter and its datapath, ensuring high performance and reliable hardware behavior.
- **Quartus**: Used for synthesis and implementation on the FPGA.
- **Modelsim**: Utilized for creating comprehensive testbenches to verify and simulate the functionality of every feature in the design.
- **Testbenches**: Extensive testbenches were written to ensure every functionality was thoroughly verified.

## How it Works

1. **Instruction Fetch**: ARM assembly instructions are fetched and decoded by the CPU’s control unit.
2. **Execution**: The CPU executes the instructions, leveraging the datapath for operations like data manipulation, memory access, and branching.
3. **Memory and I/O**: The CPU interacts with memory and I/O switches+buttons for operations that require data storage or retrieval.
4. **Control Logic**: The control unit ensures proper instruction sequencing and execution, coordinating all parts of the CPU.

## Testing
- Extensive unit tests and testbenches are provided to validate the functionality of the CPU.
- Testbenches are written in SystemVerilog and use Modelsim for simulation
- The project was run on an Altera DE1-SOC FPGA and tested with the top module to use switches and hex displays for input and output.

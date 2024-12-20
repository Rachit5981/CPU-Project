# 16-bit CPU Project

## Project Overview
This project aims to design and develop a 16-bit CPU using Verilog, based on a flexible and evolving architecture. The primary goal is to create a versatile CPU that supports a range of arithmetic, logical, and memory operations, while also focusing on efficiency and optimization techniques. The CPU has been implemented having features as mentioned below.

## Project Vision
The objective is to build a robust CPU capable of handling a wide variety of instructions with efficient data processing capabilities. This architecture will be adaptable, and additional features will be integrated as the design evolves. We are open to expanding the CPU's capabilities and exploring new design possibilities as the project progresses.

## Components
- **ALU (Arithmetic Logic Unit)**: The ALU currently supports the following operations:
  - **Arithmetic operations**: ADD, SUB
  - **Logical operations**: AND, OR, XOR, NOT
  - **Bitwise operations**: Shift and Set Less Than

- **Register File**:The Register File currently supports the following operations:
  - **Write Operation**: Write data to a specified register when enabled.
  - **Read Operations**: Read data from two specified registers.

- **Memory Bank**:The Memory Bank supports the following operations:
  - **Read**: Outputs data from the specified memory address when mem_read is asserted.
  - **Write**: Stores data to the specified memory address when mem_write is asserted.

- **Control Unit**:The Control Unit generates control signals for various operations based on the instruction received. It performs the following tasks:
  - **ALU Operation**: Based on the instruction's opcode, it sets the appropriate ALU operation (alu_op) to be performed.
  - **Memory Read**: When mem_read is asserted, the unit allows data to be read from memory for instructions like Load Word (LW).
  - **Memory Write**: When mem_write is asserted, the unit allows data to be written to memory for instructions like Store Word (SW).
  - **Register Write**: When reg_write is asserted, the unit allows data to be written to a specified register (write_reg), used in instructions like ADD, SUB, AND, OR, and LW.
  - **Write Register**: Based on the instruction, it specifies which register (write_reg) will receive the result, ensuring that the correct data is stored.

- **Hazard Detection Unit**: The Hazard Detection Unit is responsible for detecting potential data hazards that could arise during instruction execution. It performs the following tasks:
  - **Hazard Detection**: Monitors if the instruction in the IF/ID pipeline register could cause a data hazard by checking if a load operation is pending and if any register used in the current instruction is being written to by the load instruction in the ID/EX stage.
  - **Hazard Detected**: When a hazard is detected (i.e., the instruction in IF/ID requires a register that is being written by a load instruction in the ID/EX stage), the unit asserts hazard_detected to signal the need for stalling or other hazard mitigation strategies.

- **CPU**: The CPU is responsible for coordinating the execution of instructions in a pipelined manner. It performs the following tasks:
  - **Instruction Fetch (IF)**: The instruction is fetched from memory based on the Program Counter (PC). The instruction is then passed to the next stage (Instruction Decode) for further processing. The PC is updated unless a hazard is detected.
  - **Instruction Decode (ID)**: The instruction is decoded, and control signals are generated by the Control Unit. Register values are read from the Register File for use in the Execute stage. Data hazards are checked, and if a hazard is detected, the pipeline is stalled.
  - **Execute (EX)**: The ALU performs the appropriate operation (e.g., addition, subtraction) using the data from the registers. The result is forwarded to the next stage (Memory Access).
  - **Hazard Detection**: The Hazard Detection Unit checks if any instruction in the pipeline could cause a data hazard by examining the current instruction and the instruction in the Execute stage.
  - **Memory Access (MEM)**: Based on control signals, data may be read or written to memory during this stage. The result of the ALU operation is passed to the next stage if no memory access is required.
  - **Write-back (WB)**: The result of the memory operation or ALU operation is written back to the Register File if required.

## Planned Features
The CPU design will likely include, but is not limited to, the following features:

- **16-bit data path** for a balance between complexity and performance.
- **Flexible instruction set** supporting various data manipulation and memory operations.
- Support for both **R-type and I-type instructions**, with potential future expansion.
- **Load and Store operations** to interact with memory effectively.
- **Scalability** to accommodate future enhancements like additional registers or extended word sizes.
- **Optimization techniques** to handle control flow and data hazards efficiently.

## Simulation and Testing

### Testbench Strategy
A comprehensive testbench will be developed to verify the functionality of the CPU at every stage of its design. The testbench will generate a variety of instructions, stimulate the CPU's operation, and validate its outputs to ensure correct behavior.

The testbench will focus on:
- **Validating arithmetic and logical operations** performed by the ALU.
- **Monitoring control signals** to ensure accurate instruction execution.
- **Detecting and debugging issues** in data handling and memory operations.

### Simulation Tools
We plan to use Verilog simulation tools like ModelSim or Icarus Verilog for compiling and running the testbench. Waveform viewers like GTKWave will be used to visualize internal signals and debug the CPU's behavior.

## Future Enhancements
As the project evolves, the following potential enhancements will be considered:

- **Advanced branching and control flow mechanisms** for efficient execution.
- **Support for floating-point operations** for more complex computations.
- **Introduction of cache memory** to improve data access speeds.
- **Extending the architecture** to support 32-bit or 64-bit operations.
- **Interrupt handling and exception management** to make the CPU more robust.
- **Forwarding and hazard control** to reduce pipeline stalls and optimize performance.

## Getting Started

### Prerequisites
To participate in the development or simulation of this CPU, the following tools are recommended:
- **Verilog simulation software** (e.g., ModelSim, Icarus Verilog)
- **Waveform viewer for debugging** (e.g., GTKWave)

### How to Contribute
Contributions from the community are encouraged! Feel free to fork the repository, make improvements, and submit pull requests to help enhance the design and functionality of the CPU.

## License
This project is open-source and available under the MIT License.

## Acknowledgments
- Inspired by traditional RISC-based CPU architectures.
- Developed as a learning project for understanding digital circuit design and CPU implementation concepts.

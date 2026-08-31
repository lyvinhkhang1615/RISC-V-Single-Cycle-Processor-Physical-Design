# RISC-V 32-bit Single-Cycle Processor
### RTL Design and RTL-to-GDSII Physical Implementation using Cadence Encounter

A 32-bit RISC-V Single-Cycle Processor implemented at RTL level and taken through the digital physical design flow from synthesized netlist to GDSII using Cadence Encounter.

---

## 📌 Project Overview

This project focuses on the design and physical implementation of a **32-bit RISC-V Single-Cycle Processor**.

The project is divided into two main stages:

- **RTL Design** – implementation of the RISC-V processor using Verilog HDL.
- **Physical Design** – implementation of the synthesized design using **Cadence Encounter RTL-to-GDSII**.

The physical design flow includes:

```text
RTL
 │
 ▼
Synthesis
 │
 ▼
Gate-Level Netlist
 │
 ▼
Floorplan
 │
 ▼
Power Planning
 │
 ▼
Placement
 │
 ▼
Clock Tree Synthesis (CTS)
 │
 ▼
Routing
 │
 ▼
Post-Route Optimization
 │
 ▼
Physical Verification
 │
 ▼
GDSII

The main objective is to understand the complete digital IC implementation flow from RTL to a physical layout.

🧠 Processor Architecture

The processor follows the Single-Cycle RISC-V architecture, where each instruction is executed within a single clock cycle.

The main functional blocks include:

Program Counter (PC)
Instruction Memory
Register File
ALU
Control Unit
Immediate Generator
Data Memory
Multiplexers
Branch / Jump Address Generation
Result Selection Logic

A simplified datapath can be represented as:

                  ┌──────────────────┐
                  │  Program Counter │
                  └────────┬─────────┘
                           │
                           ▼
                  ┌──────────────────┐
                  │ Instruction Mem. │
                  └────────┬─────────┘
                           │
                           ▼
        ┌─────────────────────────────────────┐
        │            Control Unit             │
        └─────────────────────────────────────┘
                           │
                           ▼
                  ┌──────────────────┐
                  │  Register File   │
                  └────────┬─────────┘
                           │
                 ┌─────────┴─────────┐
                 ▼                   ▼
          ┌──────────────┐    ┌──────────────┐
          │ Immediate    │    │     ALU      │
          │ Generator    │    │              │
          └──────────────┘    └──────┬───────┘
                                     │
                              ┌──────▼───────┐
                              │ Data Memory  │
                              └──────┬───────┘
                                     │
                                     ▼
                              ┌──────────────┐
                              │ Result Mux   │
                              └──────┬───────┘
                                     │
                                     ▼
                              Register File
📚 RISC-V Instruction Set

The processor is based on the RV32I instruction set architecture.

The following instruction groups are considered in the design:

Type	Instructions
R-Type	ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
I-Type	JALR, LB, LH, LW, LBU, LHU, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
S-Type	SB, SH, SW
B-Type	BEQ, BNE, BLT, BGE, BLTU, BGEU
U-Type	LUI, AUIPC
J-Type	JAL
Implemented Instructions

The RTL implementation currently supports:

Type	Instructions
R	ADD, SUB, SLT, SLTU, XOR, SRL, SRA, OR, AND
I	LB, LH, LW, LBU, LHU, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
S	SB, SH, SW
B	BEQ
U	LUI, AUIPC
J	-

The instruction set can be extended in future versions to support the remaining branch and jump instructions.

🔧 RTL Design

The processor was described using Verilog HDL.

The RTL design is organized into multiple reusable modules.

Main RTL Modules
Module	Description
Single_Cycle_Top.v	Top-level processor module
Single_Cycle_Core.v	Main processor core
Core_Datapath.v	Processor datapath
Control_Unit.v	Main control logic
Main_Decoder.v	Instruction decoding
ALU.v	Arithmetic and logic operations
ALU_decoder.v	ALU operation decoding
Register_File.v	32-register register file
Instruction_Memory.v	Instruction memory
Data_Memory.v	Data memory
PC.v	Program Counter
PC_Plus_4.v	PC + 4 calculation
PC_Target.v	Branch target calculation
PC_Mux.v	PC source selection
ALU_Mux.v	ALU operand selection
Result_Mux.v	Write-back result selection
Extend.v	Immediate value extension
🧪 Simulation and Verification

Before physical implementation, the RTL design should be verified through simulation.

Testbenches are provided for individual modules as well as the complete processor.

Example verification structure:

RTL
 │
 ├── ALU
 │     └── ALU_tb
 │
 ├── Register File
 │     └── Register_File_tb
 │
 ├── Control Unit
 │     └── Control_Unit_tb
 │
 ├── Data Memory
 │     └── Data_Memory_tb
 │
 └── Single Cycle Core
       └── Single_Cycle_Core_tb

The testbench environment is used to verify:

ALU operations
Register read/write operations
Immediate generation
Instruction decoding
Memory read/write
PC operation
Branch behavior
Processor datapath
Overall processor operation
🏗️ Physical Design

After RTL verification and synthesis, the gate-level netlist is used for physical implementation.

The physical design was performed using:

Cadence Encounter RTL-to-GDSII System

The implementation flow consists of:

1. Design Import

The synthesized gate-level netlist, timing constraints and technology libraries are imported into Encounter.

Main inputs include:

Gate-level netlist
Technology LEF
Standard-cell LEF
Timing libraries
SDC constraints
2. Floorplan

The initial floorplan defines:

Core area
Die area
Core utilization
Aspect ratio
Standard-cell placement area
I/O pin region

The floorplan provides the physical boundary in which the processor is implemented.

3. Power Planning

Power distribution networks are created to provide stable power and ground connections to the standard cells.

The power planning stage includes:

Power rings
Power straps
Standard-cell power rails
VDD connection
VSS connection
Via connections between power layers

A multi-layer power mesh is used to distribute the power supply across the core.

4. Placement

The synthesized standard cells are placed inside the core area.

The placement stage considers:

Cell legality
Timing
Congestion
Cell density
Routing resources

After placement, the design is checked to make sure that cells are properly placed inside the core.

5. Clock Tree Synthesis

Clock Tree Synthesis (CTS) is performed to distribute the clock signal throughout the design.

The CTS stage aims to control:

Clock skew
Clock latency
Clock transition
Clock routing
Clock buffer/inverter insertion
6. Routing

The routing stage connects all placed cells according to the synthesized netlist.

Routing is performed in multiple metal layers.

The main objectives are:

Complete all signal connections
Complete power connections
Avoid routing violations
Reduce congestion
Meet design rules
7. Post-Route Optimization

After routing, timing optimization is performed to improve the final design.

The design is checked for:

Setup timing
Hold timing
Clock timing
Signal integrity
Routing violations
🖥️ Physical Design Result

The following image shows the final physical layout of the RISC-V Single-Cycle Processor implemented using Cadence Encounter.

Layout Highlights

The final layout contains:

Standard-cell logic
Instruction/Data memory regions
Power distribution network
Clock network
Signal routing
I/O pins
Core boundary

The layout demonstrates the transformation from a synthesized digital design into a physical IC implementation.

🔍 Physical Verification

Several checks are performed after placement and routing.

Connectivity Check

Verifies that all required electrical connections are present.

verifyConnectivity
Geometry / DRC Check

Checks physical design-rule violations.

verifyGeometry
Timing Analysis

Post-route timing is analyzed to verify setup and hold constraints.

timeDesign -postRoute
Antenna Check

Checks for potential antenna violations caused by metal routing.

verifyProcessAntenna
📊 Implementation Checks

The final implementation should satisfy the following major requirements:

Check	Objective
Placement	All standard cells legally placed
Connectivity	No unintended open connections
Power	VDD/VSS properly distributed
CTS	Clock network implemented
Routing	All signal nets routed
DRC	No design-rule violations
Antenna	No antenna violations
Setup Timing	Timing constraints satisfied
Hold Timing	Timing constraints satisfied
GDSII	Final layout database generated
📁 Repository Structure
RISC_V_Single_Cycle_Processor/
│
├── README.md
├── LICENSE
├── instructions.txt
│
├── rtl/
│   ├── ALU_decoder.v
│   ├── ALU_Mux.v
│   ├── ALU.v
│   ├── Control_Unit.v
│   ├── Core_Datapath.v
│   ├── Data_Memory.v
│   ├── Extend.v
│   ├── Instruction_Memory.v
│   ├── Main_Decoder.v
│   ├── PC_Mux.v
│   ├── PC_Plus_4.v
│   ├── PC_Target.v
│   ├── PC.v
│   ├── Register_File.v
│   ├── Result_Mux.v
│   ├── Single_Cycle_Core.v
│   └── Single_Cycle_Top.v
│
├── tb/
│   ├── ALU_Decoder_tb.v
│   ├── ALU_Mux_tb.v
│   ├── ALU_tb.v
│   ├── Control_Unit_tb.v
│   ├── Core_Datapath_tb.v
│   ├── Data_Memory_tb.v
│   ├── Extend_tb.v
│   ├── Instruction_Memory_tb.v
│   ├── Main_Decoder_tb.v
│   ├── PC_Mux_tb.v
│   ├── PCPlus4_tb.v
│   ├── PC_Target_tb.v
│   ├── PC_tb.v
│   ├── Register_File_tb.v
│   ├── Register_tb.v
│   ├── Result_Mux_tb.v
│   ├── Single_Cycle_Core_tb.v
│   └── Single_Cycle_TB.v
│
├── physical_design/
│   ├── floorplan/
│   ├── powerplan/
│   ├── placement/
│   ├── cts/
│   ├── routing/
│   └── reports/
│
└── images/
    └── final_layout.png
🛠️ Tools and Technologies
Hardware Description Language
Verilog HDL
RISC-V RV32I ISA
RTL / Logic Design
RTL design
Digital logic design
Single-cycle datapath
Processor control unit
Physical Design
Cadence Encounter RTL-to-GDSII
Standard-cell based physical design
Floorplanning
Power Planning
Placement
Clock Tree Synthesis
Routing
Timing Analysis
Physical Verification
GDSII generation
📐 Design Flow

The complete project flow can be summarized as:

                 RISC-V ISA
                     │
                     ▼
              RTL / Verilog
                     │
                     ▼
             RTL Verification
                     │
                     ▼
                Synthesis
                     │
                     ▼
             Gate-Level Netlist
                     │
                     ▼
              Cadence Encounter
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
      Floorplan             Constraints
          │
          ▼
     Power Planning
          │
          ▼
       Placement
          │
          ▼
          CTS
          │
          ▼
        Routing
          │
          ▼
   Post-Route Optimization
          │
          ▼
 Physical Verification
          │
          ▼
        GDSII
🎯 Project Objectives

The main objectives of this project are:

Understand the architecture of a 32-bit RISC-V processor.
Implement a single-cycle processor using Verilog HDL.
Understand the datapath and control path of a CPU.
Verify the RTL design using simulation.
Understand the transition from RTL to gate-level netlist.
Perform physical implementation using Cadence Encounter.
Understand floorplanning and power distribution.
Perform standard-cell placement.
Perform Clock Tree Synthesis.
Perform signal and power routing.
Analyze post-route timing.
Perform physical verification.
Generate the final GDSII layout.
📌 Current Status
RTL
 Processor datapath
 Control unit
 ALU
 Register file
 Instruction memory
 Data memory
 Immediate generation
 Branch logic
 RTL verification
Physical Design
 Netlist import
 Floorplan
 Power planning
 Placement
 Clock Tree Synthesis
 Routing
 Post-route optimization
 Physical verification
 Final layout
 GDSII generation
🚧 Future Improvements

Possible future improvements include:

Implement the remaining RV32I instructions.
Improve processor verification coverage.
Optimize area utilization.
Improve timing performance.
Reduce routing congestion.
Optimize power distribution.
Perform more detailed power analysis.
Perform STA across multiple PVT corners.
Compare different placement and routing strategies.
Further optimize the final physical layout.
📖 Reference

The RTL implementation was developed with reference to the following open-source project:

RISC-V Single Cycle Processor – Govardhan N.

GitHub Repository

The referenced project is itself based on:

Digital Design and Computer Architecture: RISC-V Edition
Sarah L. Harris and David Harris

The original repository contains an RTL implementation of a 32-bit RISC-V Single-Cycle Processor and is distributed under the MIT License.

Note: The RTL implementation in this project was referenced/adapted from the above work. The physical design flow, including floorplanning, power planning, placement, CTS, routing, verification, and RTL-to-GDSII implementation, was performed as part of this project.

📜 License

This project is provided for educational and research purposes.

If portions of the RTL are derived from the referenced MIT-licensed project, the original copyright and license notices should be retained where applicable.

See LICENSE for the license applicable to this repository.

👤 Author

Lý Vĩnh Khang

Electronics & Telecommunications Engineering

Ho Chi Minh City University of Technology and Education (HCMUTE)

⭐ Acknowledgement

Special thanks to the authors of the referenced RISC-V Single-Cycle Processor project and to the authors of:

Digital Design and Computer Architecture: RISC-V Edition

by Sarah L. Harris and David Harris.

📷 Final Layout Preview


### Có 2 chỗ m cần làm trước khi push

**1. Đặt ảnh layout**

Tạo thư mục:

```text
images/

rồi đặt ảnh m gửi vào:

images/final_layout.png

README sẽ tự hiện ảnh bằng:

![Final RISC-V Processor Layout](Layout_Final1.png)

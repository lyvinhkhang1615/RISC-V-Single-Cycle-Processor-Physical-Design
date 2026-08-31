# RISC-V-Single-Cycle-Processor-Physical-Design

My implementation of a **32-bit RISC-V Single Cycle Processor**, followed by an **ASIC Physical Design flow using Cadence Encounter**.

The project covers both the RTL implementation of the processor and the physical implementation from synthesized netlist to final GDSII.

---

## Reference

Reference Textbook:

`Digital Design and Computer Architecture: RISC-V Edition`
by Sarah L. Harris and David Harris

---

## Single Cycle Processor

The processor is based on a single-cycle architecture, where each instruction is completed within a single clock cycle.

### Processor Design Specification

![Single Cycle Processor](https://user-images.githubusercontent.com/37037342/232227351-18115bc2-6f23-4f39-a2f4-f87c626f9750.png)

---

## Instructions Implemented

| Type | Instructions | Implemented |
|------|--------------|-------------|
| R | ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND | ADD, SUB, SLT, SLTU, XOR, SRL, SRA, OR, AND |
| I | JALR, LB, LH, LW, LBU, LHU, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI | LB, LH, LW, LBU, LHU, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI |
| S | SB, SH, SW | SB, SH, SW |
| B | BEQ, BNE, BLT, BGE, BLTU, BGEU | BEQ |
| U | LUI, AUIPC | LUI, AUIPC |
| J | JAL | - |

### Current Status

**25 instructions are currently implemented.**

The following instructions are not implemented yet:

```text
JALR
BNE
BLT
BGE
BLTU
BGEU
JAL
RTL Design
The processor is implemented using Verilog HDL.

The main RTL modules include:
ALU
Register File
Control Unit
Instruction Memory
Data Memory
Program Counter
Immediate Extension
Multiplexers
Core Datapath
ASIC Physical Design

After RTL development and synthesis, the design is taken through an ASIC physical design flow using Cadence Encounter.
The physical design flow consists of:

RTL
 │
 ▼
Logic Synthesis
 │
 ▼
Gate-Level Netlist
 │
 ▼
Design Import
 │
 ▼
Floorplan
 │
 ▼
I/O Placement
 │
 ▼
Power Planning
 │
 ▼
Placement
 │
 ▼
Clock Tree Synthesis
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
Physical Design Tool
Cadence Encounter 13.10

The following stages are performed in Encounter:
Design Import
Floorplanning
I/O Pin Placement
Power Planning
Standard Cell Placement
Clock Tree Synthesis (CTS)
Routing
Post-Route Optimization
Physical Verification
Timing Analysis
GDSII Generation

1. Floorplanning
The synthesized netlist is imported into Cadence Encounter and the initial floorplan is created.
The floorplanning stage includes:
Die/core definition
Core utilization
Aspect ratio
Placement boundaries
Macro placement
Routing considerations
The floorplan provides the physical area in which the processor cells are placed.

2. I/O Pin Placement
The processor input and output ports are placed around the core boundary.
Different metal layers can be assigned to different groups of ports according to the routing requirements.
Example ports include:

clk_i
rst_i
rst_cpu_i

axi_i_*
axi_t_*

intr_i[*]

The I/O pins are fixed after placement to prevent unintended movement during later physical-design stages.

3. Power Planning
A Power Distribution Network (PDN) is created to distribute the power and ground nets throughout the processor.
The power network consists of:
Power Ring
     │
     ▼
Power Straps
     │
     ▼
Standard Cell Power Rails

Multiple metal layers are used for power distribution.
Power Mesh
The power mesh uses the following metal layers:
Mesh	Horizontal Layer	Vertical Layer
MESH1	M9	M8
MESH2	M7	M6
MESH3	M5	M4
MESH4	M3	M2
Standard Cell Rail	M1	-
The higher metal layers are used for the global power network, while M1 provides power connections to standard cells.

4. Standard Cell Placement
After power planning, standard cells are placed inside the core area.
The placement stage aims to achieve:
Legal cell placement
Low routing congestion
Good timing
Efficient area utilization
Reduced interconnect length
Placement is verified before proceeding to CTS.

5. Clock Tree Synthesis
Clock Tree Synthesis (CTS) is performed to distribute the clock signal to sequential elements.
The main objectives are:
Reduce clock skew
Control clock latency
Improve clock transition
Satisfy setup timing
Satisfy hold timing
The clock network is built before final signal routing.

6. Routing
After placement and CTS, signal routing is performed.
The routing stage connects the standard cells, macros, clock network, and I/O pins.
Typical Encounter commands include:
routeDesign
and post-route ECO routing:
ecoRoute
7. Post-Route Optimization
Post-route optimization is performed after routing to improve the final timing and resolve remaining violations.
Typical optimization targets include:
Setup violations
Hold violations
Transition violations
Capacitance violations
Routing-related violations
Example:
optDesign -postRoute

8. Physical Verification
Several physical verification checks are performed after routing.
Connectivity:
verifyConnectivity -type all
Checks the physical connectivity of the design.

Geometry:
verifyGeometry -report ./reports/final_drc.rpt
Checks physical geometry violations.

DRC:
verify_drc
Checks design-rule violations.

Antenna:
verifyProcessAntenna
Checks process antenna violations.

9. Timing Analysis
Post-route timing analysis is performed to evaluate the timing performance of the processor.
timeDesign -postRoute
The main timing parameters include:
Setup Slack
Hold Slack
Worst Negative Slack (WNS)
Total Negative Slack (TNS)
Clock Skew
Data Arrival Time
Required Arrival Time
Both setup and hold timing are checked before final sign-off.

10. Final Design Verification
Before generating the final layout, the following checks are performed:
Placement
   │
   ├── Legal Placement
   │
   ▼
Connectivity
   │
   ▼
DRC
   │
   ▼
Antenna
   │
   ▼
Timing
   │
   ▼
Final Database
The design is considered ready for final output after the physical and timing checks are completed successfully.

11. GDSII Generation
The final Encounter database is saved and the physical layout is exported to GDSII.
Example:
saveDesign ./final_encounter.enc
streamOut ./top_module.gds
Final outputs include:
final_encounter.enc
top_module.gds
Directory Structure
├── instructions.txt
├── LICENSE
├── README.md
│
├── rtl
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
├── tb
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
└── encounter
    ├── scripts
    ├── reports
    ├── outputs
    └── final_encounter.enc
Project Results
The physical design flow generates the following results:
Synthesized gate-level netlist
Floorplan
I/O placement
Power distribution network
Standard-cell placement
Clock tree
Routed layout
Timing reports
DRC reports
Connectivity reports
Final Encounter database
GDSII layout
Project Summary
This project combines RISC-V processor design with an ASIC Physical Design flow.
The RTL implementation demonstrates the architecture and functionality of a 32-bit RISC-V Single Cycle Processor, while the physical design stage demonstrates the transformation of the synthesized design into a physical chip layout using Cadence Encounter.

RISC-V RTL
     │
     ▼
Synthesis
     │
     ▼
Cadence Encounter
     │
     ├── Floorplan
     ├── I/O Placement
     ├── Power Planning
     ├── Placement
     ├── CTS
     ├── Routing
     └── Verification
     │
     ▼
GDSII

---

## Acknowledgements
The RTL implementation of the RISC-V Single-Cycle Processor was referenced and adapted from:
**RISC-V Single Cycle Processor by Govardhan (govardhnn)**  
:contentReference[oaicite:0]{index=0}
The RTL source was used as a reference for this project. The ASIC Physical Design flow, including floorplanning, I/O placement, power planning, placement, CTS, routing, physical verification, timing analysis, and GDSII generation, was performed using Cadence Encounter.
---
Author
Lý Vĩnh Khang
Electronics and Telecommunications Engineering
Ho Chi Minh City University of Technology and Engineering (HCMUTE)

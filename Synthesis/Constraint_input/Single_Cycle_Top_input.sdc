#=============================================================================
# Single_Cycle_Top.sdc
# Synthesis constraints - RISC-V Single Cycle Core, GPDK045
# Target tool: Cadence Genus / RC Compiler
#
# Top module ports (from Single_Cycle_Top.v):
#   input  clk, reset
#   output [31:0] WriteData, DataAddr
#   output MemWrite
#=============================================================================

#-----------------------------------------------------------------------------
# 1. Clock definition
#-----------------------------------------------------------------------------
# Start conservative (100 MHz / 10ns). This is a SINGLE CYCLE design, so the
# clock period must cover the full combinational path:
#   PC -> Instruction_Memory(macro, registered) -> Control_Unit -> Datapath
#        -> ALU -> Data_Memory(macro, registered) -> back to PC mux
# Run first synthesis pass, check worst negative slack (WNS) in the timing
# report, then tighten this period down (do NOT trust 10ns blindly - the
# real achievable period is combinational-path dependent, not the macro's
# own min_period of 1.5ns from the .lib, which is only a lower bound).

create_clock -name CLK -period 10.000 [get_ports clk]

set_clock_uncertainty 0.150 [get_clocks CLK]
set_clock_transition   0.100 [get_clocks CLK]
set_clock_latency      0.300 [get_clocks CLK]

#-----------------------------------------------------------------------------
# 2. Reset (asynchronous, active-high - see PC.v: posedge clk or posedge reset)
#-----------------------------------------------------------------------------
# Treated as a regular async data input; recovery/removal checks are
# derived automatically from the standard cell library. We just need a
# reasonable input delay so STA has a launch point.

set_input_delay -clock CLK 1.000 [get_ports reset]
set_false_path -from [get_ports reset] -to [all_registers]
# ^ Uncomment the false_path line ONLY if reset is driven by a slow,
#   testbench-only source (e.g. a power-on reset generator) that will
#   never toggle close to a clock edge in real operation. If reset is
#   meant to be a synchronizing signal you care about timing-wise,
#   remove this line and let the tool check recovery/removal normally.

#-----------------------------------------------------------------------------
# 3. Primary inputs (excluding clk/reset)
#-----------------------------------------------------------------------------
set all_in_no_clk [remove_from_collection [all_inputs] [get_ports {clk reset}]]

set_input_delay  -clock CLK 2.000 $all_in_no_clk
set_driving_cell -lib_cell BUFX2 -pin Z [get_lib_cells */BUFX2] $all_in_no_clk
# ^ Replace BUFX2 with an actual buffer cell name from your GPDK045 std
#   cell library if BUFX2 doesn't exist; check with:
#   report_lib_cell -all | grep -i buf

#-----------------------------------------------------------------------------
# 4. Primary outputs
#-----------------------------------------------------------------------------
set_output_delay -clock CLK 2.000 [all_outputs]
set_load 0.050 [all_outputs]

#-----------------------------------------------------------------------------
# 5. Design rule constraints
#-----------------------------------------------------------------------------
set_max_transition 1.000 [current_design]
set_max_fanout      16    [current_design]
set_max_capacitance 0.500 [current_design]

#-----------------------------------------------------------------------------
# 6. Memory macros (MEM1_256X32 x2 - Instruction_Memory, Data_Memory)
#-----------------------------------------------------------------------------
# Macro .lib already defines its own internal setup/hold constraints
# (CE/WE/A/D relative to CK) and memory_read()/memory_write() timing arcs,
# so no extra SDC needed here as long as the macro's CK pin is driven
# directly by the same CLK network defined above (it is, in both wrappers).
#
# Optional: if Genus complains about the macro's min_period (1.5ns) vs.
# your chosen clock period, that is fine - min_period is a LOWER bound
# (macro must be faster than the clock), not an equality requirement.

#-----------------------------------------------------------------------------
# 7. Environment
#-----------------------------------------------------------------------------
set_operating_conditions -library MEM1_256X32 slow

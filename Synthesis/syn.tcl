#=============================================================================
# syn.tcl
# RC Compiler / Genus synthesis script
# RISC-V Single Cycle Core - GPDK045, with MEM1_256X32 SRAM macro
#=============================================================================

#-----------------------------------------------------------------------------
# 0. Paths - edit for your machine
#-----------------------------------------------------------------------------
set RTL_DIR    "/home/buet/Documents/RISC_V_SCP/Synthesis"
set CONS_DIR   "/home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/Constraint_input"
set LIB_DIR    "/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/timing"
# Physical LEF directory - must contain both the standard-cell LEF and the
# macro LEF. Split into two variables if they live in different paths.
set LEF_DIR    "/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045"
set OUT_DIR    "/home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/syn_out"
set DESIGN     "Single_Cycle_Top"

file mkdir $OUT_DIR

#-----------------------------------------------------------------------------
# 1. Library setup
#-----------------------------------------------------------------------------
# lef_library requires both the standard-cell LEF and the macro LEF -
# missing either one leaves the tool without physical pin/bbox data for
# that cell during P&R.
set_attribute lef_library " \
    $LEF_DIR/gsclib045.lef \
    $LEF_DIR/lef/MEM1_256X32.lef \
" /
set_attribute lib_search_path $LIB_DIR

# Standard cell library - replace with your actual GPDK045 std-cell .lib
set_attribute library { \
    slow.lib \
    MEM1_256X32_slow.lib \
} /

#-----------------------------------------------------------------------------
# 2. Read RTL
#-----------------------------------------------------------------------------
set_attribute hdl_search_path $RTL_DIR /

read_hdl -sv { \
    MEM1_256X32_stub.v \
    ALU.v \
    ALU_decoder.v \
    ALU_Mux.v \
    Control_Unit.v \
    Core_Datapath.v \
    Data_Memory.v \
    Extend.v \
    Instruction_Memory.v \
    Main_Decoder.v \
    PC.v \
    PC_Mux.v \
    PC_Plus_4.v \
    PC_Target.v \
    Register_File.v \
    Result_Mux.v \
    Single_Cycle_Core.v \
    Single_Cycle_Top.v \
}

elaborate $DESIGN

#-----------------------------------------------------------------------------
# 3. Macro dont_touch/dont_use are already set at the cell level in the
#    library, no extra attribute needed here.
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# 4. Constraints
#-----------------------------------------------------------------------------
read_sdc $CONS_DIR/Single_Cycle_Top_input.sdc

check_design -unresolved

#-----------------------------------------------------------------------------
# 5. Synthesis
#-----------------------------------------------------------------------------
synthesize -to_generic
synthesize -to_mapped -effort high -incremental

#-----------------------------------------------------------------------------
# 6. Reports
#-----------------------------------------------------------------------------
report timing               > $OUT_DIR/${DESIGN}_timing.rpt
report area                 > $OUT_DIR/${DESIGN}_area.rpt
report power                > $OUT_DIR/${DESIGN}_power.rpt
report gates                > $OUT_DIR/${DESIGN}_gates.rpt

#-----------------------------------------------------------------------------
# 7. Outputs for P&R (Encounter/EDI)
#-----------------------------------------------------------------------------
write_hdl                    > $OUT_DIR/${DESIGN}_netlist.v
write_sdc                    > /home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/syn_out/Constraint_output/${DESIGN}_output.sdc
write_sdf                     $OUT_DIR/${DESIGN}.sdf

write_design -basename $OUT_DIR/${DESIGN}_db
gui_show
puts "==== Synthesis complete. Check $OUT_DIR/${DESIGN}_timing.rpt for WNS/TNS before P&R. ===="

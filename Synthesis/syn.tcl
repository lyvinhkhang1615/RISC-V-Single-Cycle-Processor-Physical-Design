#=============================================================================
# syn.tcl
# RC Compiler / Genus synthesis script
# RISC-V Single Cycle Core - GPDK045, with MEM1_256X32 SRAM macros
#=============================================================================

#-----------------------------------------------------------------------------
# 0. EDIT THESE PATHS FOR YOUR MACHINE
#-----------------------------------------------------------------------------
set RTL_DIR    "/home/buet/Documents/RISC_V_SCP/Synthesis"
set CONS_DIR   "/home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/Constraint_input"
set LIB_DIR    "/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/timing"
# Thêm mới: thư mục chứa LEF vật lý — cả LEF của standard cell lẫn LEF
# của macro MEM1_256X32. Nếu 2 file này nằm ở 2 thư mục khác nhau trên
# máy bạn, tách thành 2 biến riêng, đừng gộp chung.
set LEF_DIR    "/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045"
set OUT_DIR    "/home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/syn_out"
set DESIGN     "Single_Cycle_Top"

file mkdir $OUT_DIR

#-----------------------------------------------------------------------------
# 1. Library setup
#-----------------------------------------------------------------------------
# lef_library nhận danh sách nhiều file — PHẢI có cả LEF standard cell lẫn
# LEF macro, thiếu cái nào thì tool không biết pin/bbox vật lý của cái đó
# khi qua bước P&R (Encounter đọc lại đúng LEF đã khai ở đây).
set_attribute lef_library " \
    $LEF_DIR/gsclib045.lef \
    $LEF_DIR/lef/MEM1_256X32.lef \
" /
set_attribute lib_search_path $LIB_DIR

# Standard cell library - REPLACE with your actual GPDK045 std cell .lib
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
# 3. Macro dont_touch đã khai ở cấp cell trong .lib, không cần thêm gì
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# 4. Constraints — đọc file SDC đầu vào (Single_Cycle_Top.sdc)
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
# 7. Outputs for the P&R stage (Encounter/EDI)
#-----------------------------------------------------------------------------
write_hdl                    > $OUT_DIR/${DESIGN}_netlist.v
write_sdc                    > /home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/syn_out/Constraint_output/${DESIGN}_output.sdc
write_sdf 		     > $OUT_DIR/${DESIGN}.sdf

write_design -basename $OUT_DIR/${DESIGN}_db
gui_show
puts "==== Synthesis complete. Check $OUT_DIR/${DESIGN}_timing.rpt for WNS/TNS before P&R. ===="

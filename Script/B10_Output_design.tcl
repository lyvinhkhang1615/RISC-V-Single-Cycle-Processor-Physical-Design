# ===================================================================
# export_final.tcl
# Xuất dữ liệu cuối cùng sau khi Physical Verification đã sạch
# (LVS, DRC, Antenna đều 0 Violations)
# ===================================================================
# -------------------------------------------------------------
# Kiểm tra lại DRC sau khi thêm filler
verifyGeometry -report /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final/postfiller_drc.rpt
# -------------------------------------------------------------
# 1. Physical Verification cuối (Sign-off)
# -------------------------------------------------------------
verifyConnectivity -type all -report /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final/lvs_final.rpt
verifyGeometry -report /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final/drc_final.rpt
verifyProcessAntenna -report /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final/antenna_final.rpt

# -------------------------------------------------------------
# 2. Report Timing cuối (cả 2 corner: setup/slow và hold/fast)
# -------------------------------------------------------------
timeDesign -postRoute -outDir /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final -prefix final_setup
timeDesign -postRoute -hold  -outDir /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final -prefix final_hold

# Top 10 đường truyền Setup tệ nhất (Max Delay / Late Data Path)
set_global report_timing_format {timing_point net fanout slew load edge cell delay arrival}

report_timing  > /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final/worst_setup_paths.rpt"

report_timing -early> /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports_final/worst_hold_paths.rpt"

# -------------------------------------------------------------
# 4. Xuất Netlist gate-level cuối cùng
# -------------------------------------------------------------
saveNetlist /home/buet/Documents/RISC_V_SCP/PnR/Design_1/Output/Data_output/RISC_V_SCP_final_netlist.v

# -------------------------------------------------------------
# 5. Xuất SDF (Standard Delay Format)
# -------------------------------------------------------------
write_sdf /home/buet/Documents/RISC_V_SCP/PnR/Design_1/Output/Data_output/RISC_V_SCP_final.sdf

# -------------------------------------------------------------
# 6. Xuất SDC cuối cùng
# -------------------------------------------------------------
write_sdc /home/buet/Documents/RISC_V_SCP/PnR/Design_1/Output/Data_output/RISC_V_SCP_final.sdc

# -------------------------------------------------------------
# 7. Xuất DEF (tùy chọn - layout dạng text trung gian)
# -------------------------------------------------------------
defOut /home/buet/Documents/RISC_V_SCP/PnR/Design_1/Output/Data_output/RISC_V_SCP_final.def

# -------------------------------------------------------------
# 8. Xuất GDSII (dữ liệu chính để tape-out)
# -------------------------------------------------------------
# LƯU Ý: sửa lại đường dẫn mapFile và libName cho đúng GPDK045 thật
streamOut /home/buet/Documents/RISC_V_SCP/PnR/Design_1/Output/Data_output/RISC_V_SCP.gds \
    -mapFile /home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/mapFile \
    -libName DesignLib \
    -units 2000
# -------------------------------------------------------------
# 9. Lưu lại design database (để mở lại sau này nếu cần)
# -------------------------------------------------------------
saveDesign /home/buet/Documents/RISC_V_SCP/PnR/Design_1/Output/Data_output/top_module_final.enc

puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="
puts "===================================================="
puts "  Export hoan tat. Kiem tra thu muc ./output va ./reports"
puts "===================================================="

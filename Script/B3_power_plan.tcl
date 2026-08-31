#=============================================================================
# powerplan.tcl
# Full power plan (PG) creation for Single_Cycle_Top - GPDK045
# Macros: Data_Memory_u_dmem, Instr_Memory_u_imem
# Top metal layer: Metal9 (ring/stripe on M8/M9)
#=============================================================================

###############################################################
# 1. Xoa PG cu + Halo cho CA 2 macro
#    (bat buoc phai co - khong co halo se ra lai loi spacing
#     Metal1 tai pin macro, da xac nhan qua thuc te chay thu)
###############################################################
deleteAllPowerPreroutes
addHaloToBlock 5 5 5 5 Data_Memory_u_dmem
addHaloToBlock 5 5 5 5 Instr_Memory_u_imem

###############################################################
# 2. Xoa + sinh lai toan bo row (tu ne halo)
###############################################################
deleteRow -all
createRow -site CoreSite

###############################################################
# 3. Global net connect
###############################################################
globalNetConnect VDD -type pgpin -pin VDD -all
globalNetConnect VSS -type pgpin -pin VSS -all
globalNetConnect VDD -type tiehi -all
globalNetConnect VSS -type tielo -all
applyGlobalNets

###############################################################
# 4. Ring M8/M9 (top layer = Metal9)
###############################################################
addRing \
    -nets {VDD VSS} \
    -type core_rings \
    -follow core \
    -layer {top Metal8 bottom Metal8 left Metal9 right Metal9} \
    -width 2 -spacing 1.5 -offset 0.5 \
    -stacked_via_top_layer Metal9 \
    -stacked_via_bottom_layer Metal1 \
    -via_using_exact_crossover_size true

###############################################################
# 5. Stripe doc M9 + Stripe ngang M8 (tao mesh)
###############################################################
addStripe \
    -nets {VDD VSS} \
    -layer Metal8 \
    -direction vertical \
   -width 1.25 -spacing 1.5 \
    -set_to_set_distance 30 \
    -stacked_via_top_layer Metal9 \
    -stacked_via_bottom_layer Metal1 \
    -via_using_exact_crossover_size true

addStripe \
    -nets {VDD VSS} \
    -layer Metal9 \
    -direction horizontal \
    -width 1.25 -spacing 1.5 -set_to_set_distance 30 \
    -stacked_via_top_layer Metal9 \
    -stacked_via_bottom_layer Metal1 \
    -via_using_exact_crossover_size true

###############################################################
# 6. sroute M1 -> M9 (follow-pin rail)
###############################################################
sroute \
    -connect {corePin} \
    -layerChangeRange {Metal1 Metal9} \
    -nets {VDD VSS} \
    -allowJogging true \
    -allowLayerChange true

###############################################################
# 7. Verify
###############################################################
verifyGeometry -report ./reports/preplace_drc.rpt
puts "==== Power plan complete (halo restored, top layer Metal9). Check ./reports/preplace_drc.rpt for violations. ===="



dbGet [dbGet head.libCells.subClass coreSpacer -p].name
set fillerCells {FILL1 FILL2 FILL4 FILL8 FILL16 FILL32 FILL64}
set BASENAME top_module
setFillerMode \
    -corePrefix ${BASENAME}_FILL \
    -core $fillerCells

addFiller \
    -cell $fillerCells \
    -prefix ${BASENAME}_FILL \
    -markFixed

###############################################################
# FINAL VERIFICATION
###############################################################
verify_drc
verifyGeometry
verifyConnectivity -type all  
verifyProcessAntenna

###############################################################
# FINAL TIMING
###############################################################

puts "========== FLOW COMPLETED =========="



###############################################################
###################### PLACEMENT ##############################
###############################################################

setPlaceMode \
    -timingDriven true \
    -congEffort auto
placeDesign
setDrawView place

###############################################################
# CHECK PLACEMENT
###############################################################

checkPlace

###############################################################
# TIMING REPORT PRE-CTS (truoc khi CTS)
###############################################################

timeDesign \
    -preCTS \
    -outDir /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports/preCTS \
    -prefix preCTS
source ../STEPS_FLOW_PD/set_max_fanout.tcl
###############################################################
# OPTIMIZE PRE-CTS (opt placement)
###############################################################
###############################################################
# TIMING AFTER OPT PRE-CTS
###############################################################
timeDesign \
    -preCTS \
    -outDir /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports/preCTS_opt\
    -prefix preCTS_opt
###############################################################
# UTILIZATION REPORT
###############################################################

redirect ./reports/preCTS/utilization.rpt {
    reportDensity
}

###############################################################
# SUMMARY REPORT
###############################################################

summaryReport \
    -outfile /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports/preCTS_opt/summary.rpt

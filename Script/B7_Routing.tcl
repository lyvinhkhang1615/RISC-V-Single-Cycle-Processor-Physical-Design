
###############################################################
###################### ROUTING ###############################
###############################################################

###############################################################
# NANOROUTE SETTINGS
###############################################################

setNanoRouteMode -routeWithTimingDriven true
setNanoRouteMode -routeWithSiDriven true
setNanoRouteMode -drouteFixAntenna true
setNanoRouteMode -routeInsertAntennaDiode true
setNanoRouteMode -routeTopRoutingLayer 9
setNanoRouteMode -routeBottomRoutingLayer 2

###############################################################
# ROUTING
###############################################################

routeDesign
#Check DRC , Antenna
verifyConnectivity -type all
verifyGeometry \
    -report /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports/postRoute_drc.rpt

###############################################################
# Neu Fix loi DRC,Antenna 
###############################################################
ecoRoute
###############################################################
# VERIFY Sau khi ECO
###############################################################
verifyConnectivity -type all
verifyGeometry \
    -report /home/buet/Documents/RISC_V_SCP/PnR/Design_1/reports/postRoute_opt_drc.rpt
verify_drc


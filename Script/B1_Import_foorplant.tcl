####################################
####################################
###                              ###
###   Student: LY HOANG KHANG	 ###
###   HCMUTE			 ###
###				 ###
####################################
####################################
###############################################################
###################### IMPORT DESIGN ##########################
###############################################################

# MMMC
set init_mmmc_file /home/buet/Documents/RISC_V_SCP/PnR/Design_1/mmmc.tcl
# Top module
set init_top_cell Single_Cycle_Top
# Netlist
set init_verilog /home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/syn_out/Single_Cycle_Top_netlist.v
# LEF
set init_lef_file {/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/gsclib045.lef /home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/lef/MEM1_256X32.lef }
# Power/Ground
set init_pwr_net VDD
set init_gnd_net VSS
# Import design
init_design

###############################################################
###################### ANALYSIS MODE ##########################
###############################################################
setAnalysisMode \
    -analysisType onChipVariation \
    -cppr both
checkDesign -all
###############################################################
###################### FLOORPLAN ##############################
###############################################################
# Check site name
dbGet top.fPlan.coreSite.name
# Floorplan
floorPlan -site CoreSite -s 450 350 15 15 15 15
#------------------------------------------------
#| Tham số              | Ý nghĩa                      |
#| ------------- | ---------------------------- |
#| `CoreSite`    | site của standard cell       |
#| `1.0`         | aspect ratio                 |
#| `0.7`         | utilization = 70%            |
#| `10 10 10 10` | margin left right top bottom |
#------------------------------------------------
#########################ARRANGE PORT##########################
# Lock tất cả pin không cho di chuyển
#--------------------------------------------------
# Clock & Reset (Left)
#--------------------------------------------------

source ../STEPS_FLOW_PD/IO_set.tcl

###############################################################
###################### POWER PLAN #############################
###############################################################
#Check site name: thường coresite vì thư viện 45nm
# Check routing layer names
dbGet [dbGet head.layers.type routing -p].name

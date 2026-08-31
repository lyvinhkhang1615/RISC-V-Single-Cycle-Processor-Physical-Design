#####################################################################
#
# RTL Compiler setup file
# Created by Encounter(R) RTL Compiler v12.10-s012_1
#   on 08/26/2026 10:15:03
#
#####################################################################


# This script is intended for use with RTL Compiler version v12.10-s012_1


# Remove Existing Design
###########################################################
if {[find -design /designs/Single_Cycle_Top] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  rm /designs/Single_Cycle_Top
}


# Libraries
###########################################################
set_attribute library {/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/timing/slow.lib /home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/timing/MEM1_256X32_slow.lib {}} /

set_attribute lef_library {/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/gsclib045.lef /home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/lef/MEM1_256X32.lef} /


# Design
###########################################################
read_netlist -top Single_Cycle_Top /home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/syn_out/Single_Cycle_Top_db.v
source /home/buet/Documents/RISC_V_SCP/Synthesis/Synthesis_0/syn_out/Single_Cycle_Top_db.g
puts "\n** Restoration Completed **\n"


# Data Integrity Check
###########################################################
# program version
if {"[string_representation [get_attribute program_version /]]" != "v12.10-s012_1"} {
   mesg_send [find -message /messages/PHYS/PHYS-91] "golden program_version: v12.10-s012_1  current program_version: [string_representation [get_attribute program_version /]]"
}
# license
if {"[string_representation [get_attribute startup_license /]]" != "RTL_Compiler_Ultra"} {
   mesg_send [find -message /messages/PHYS/PHYS-91] "golden license: RTL_Compiler_Ultra  current license: [string_representation [get_attribute startup_license /]]"
}
# slack
set _slk_ [get_attribute slack /designs/Single_Cycle_Top]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "0.1"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden slack: 0.1,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [get_attribute tns /designs/Single_Cycle_Top]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "0"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden tns: 0,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [get_attribute cell_area /designs/Single_Cycle_Top]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "114267"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden cell area: 114267,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [get_attribute net_area /designs/Single_Cycle_Top]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "5930"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden net area: 5930,  current net area: $_net_area_"
}
unset _net_area_

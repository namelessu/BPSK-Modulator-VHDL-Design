
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name test -dir "F:/test/planAhead_run_1" -part xc3s700anfgg484-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "system.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {constants.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {register.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {real2bit.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {data_gen.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {com_dac.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {bpsk.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {system.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top system $srcset
add_files [list {system.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s700anfgg484-4

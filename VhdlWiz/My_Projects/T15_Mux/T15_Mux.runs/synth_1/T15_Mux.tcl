# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/VhdlWiz/My_Projects/T15_Mux/T15_Mux.cache/wt [current_project]
set_property parent.project_path C:/VhdlWiz/My_Projects/T15_Mux/T15_Mux.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_vhdl -library xil_defaultlib C:/VhdlWiz/My_Projects/T15_Mux/T15_Mux.srcs/sources_1/imports/exercises/T15_Mux.vhd
synth_design -top T15_Mux -part xc7a35tcpg236-1
write_checkpoint -noxdef T15_Mux.dcp
catch { report_utilization -file T15_Mux_utilization_synth.rpt -pb T15_Mux_utilization_synth.pb }

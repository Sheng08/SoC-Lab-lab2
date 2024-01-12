############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project lab2_Stream
set_top fir_n11_strm
add_files hls_FIRN11Stream/FIR.cpp
add_files hls_FIRN11Stream/FIR.h
add_files -tb hls_FIRN11Stream/FIRTester.cpp
open_solution "solution1" -flow_target vivado
set_part {xck26-sfvc784-2LV-c}
create_clock -period 10 -name default
config_export -output /home/ubuntu/lab/course-lab_2/lab2_Stream
#source "./lab2_Stream/solution1/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level all
export_design -rtl verilog -format ip_catalog -output /home/ubuntu/lab/course-lab_2/lab2_Stream

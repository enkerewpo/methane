transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {D:/Github/methane/fpga/vivado_p_2023_1/methane.cache/compile_simlib/activehdl}
vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../methane.gen/sources_1/ip/clk_wiz_0" -l xpm -l xil_defaultlib \
"E:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  \
"E:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../methane.gen/sources_1/ip/clk_wiz_0" -l xpm -l xil_defaultlib \
"../../../../methane.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"


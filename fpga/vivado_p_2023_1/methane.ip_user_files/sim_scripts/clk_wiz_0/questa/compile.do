vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+../../../../methane.gen/sources_1/ip/clk_wiz_0" \
"E:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm  -93  \
"E:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../methane.gen/sources_1/ip/clk_wiz_0" \
"../../../../methane.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"


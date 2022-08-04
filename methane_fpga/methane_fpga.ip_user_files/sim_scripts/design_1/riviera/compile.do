vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_6
vlib riviera/processing_system7_vip_v1_0_8
vlib riviera/xil_defaultlib

vmap xilinx_vip riviera/xilinx_vip
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_6 riviera/axi_vip_v1_1_6
vmap processing_system7_vip_v1_0_8 riviera/processing_system7_vip_v1_0_8
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xilinx_vip  -sv2k12 "+incdir+D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_1" "+incdir+D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_6  -sv2k12 "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_1" "+incdir+D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/dc12/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_8  -sv2k12 "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_1" "+incdir+D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/2d50/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../methane_fpga.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_1" "+incdir+D:/apps/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_processing_system7_0_1/sim/design_1_processing_system7_0_1.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"


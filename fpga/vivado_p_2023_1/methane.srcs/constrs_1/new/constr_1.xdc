set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

# create_clock -period 20.000 -name sys_clock -waveform {0.000 10.000} [get_ports clk_in_50M]

set_property PACKAGE_PIN K17 [get_ports clk_in_50M]
set_property PACKAGE_PIN M19 [get_ports rst]
set_property PACKAGE_PIN M20 [get_ports btn_k2]
set_property PACKAGE_PIN Y19 [get_ports midi_rxd]

set_property PACKAGE_PIN R17 [get_ports bclk]
set_property PACKAGE_PIN T20 [get_ports ws]
set_property PACKAGE_PIN V20 [get_ports d]
set_property PACKAGE_PIN U15 [get_ports txd]

set_property IOSTANDARD LVCMOS18 [get_ports clk_in_50M]
set_property IOSTANDARD LVCMOS18 [get_ports rst]
set_property IOSTANDARD LVCMOS18 [get_ports btn_k2]
set_property IOSTANDARD LVCMOS18 [get_ports midi_rxd]

set_property IOSTANDARD LVCMOS18 [get_ports bclk]
set_property IOSTANDARD LVCMOS18 [get_ports ws]
set_property IOSTANDARD LVCMOS18 [get_ports d]
set_property IOSTANDARD LVCMOS18 [get_ports txd]
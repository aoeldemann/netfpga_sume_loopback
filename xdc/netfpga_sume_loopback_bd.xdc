# The MIT License
#
# Copyright (c) 2017-2019 by the author(s)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Author(s):
#   - Andreas Oeldemann <andreas.oeldemann@tum.de>
#
# Description:
#
# Constraint file

set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS FALSE [current_design]

# SFP_SYSCLK (156.25 MHz)
set_property PACKAGE_PIN E10 [get_ports sfp_clk_p]
set_property PACKAGE_PIN E9 [get_ports sfp_clk_n]

# reset
set_property PACKAGE_PIN AR13 [get_ports reset]
set_property IOSTANDARD LVCMOS15 [get_ports reset]
set_false_path -from [get_ports reset]

# network interface 0
set_property PACKAGE_PIN M18 [get_ports if0_tx_disable]
set_property IOSTANDARD LVCMOS15 [get_ports if0_tx_disable]
set_property PACKAGE_PIN M19 [get_ports if0_tx_fault]
set_property IOSTANDARD LVCMOS15 [get_ports if0_tx_fault]
set_property PACKAGE_PIN N18 [get_ports if0_tx_abs]
set_property IOSTANDARD LVCMOS15 [get_ports if0_tx_abs]
set_property PACKAGE_PIN G13  [get_ports if0_tx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if0_tx_led]
set_property PACKAGE_PIN L15  [get_ports if0_rx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if0_rx_led]
set_property LOC GTHE2_CHANNEL_X1Y39 \
  [get_cells -hier -filter name=~*if_0*gthe2_i]

# network interface 1
set_property PACKAGE_PIN B31 [get_ports if1_tx_disable]
set_property IOSTANDARD LVCMOS15 [get_ports if1_tx_disable]
set_property PACKAGE_PIN C26 [get_ports if1_tx_fault]
set_property IOSTANDARD LVCMOS15 [get_ports if1_tx_fault]
set_property PACKAGE_PIN L19 [get_ports if1_tx_abs]
set_property IOSTANDARD LVCMOS15 [get_ports if1_tx_abs]
set_property PACKAGE_PIN AL22  [get_ports if1_tx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if1_tx_led]
set_property PACKAGE_PIN BA20  [get_ports if1_rx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if1_rx_led]
set_property LOC GTHE2_CHANNEL_X1Y38 \
  [get_cells -hier -filter name=~*if_1*gthe2_i]

# network interface 2
set_property PACKAGE_PIN J38 [get_ports if2_tx_disable]
set_property IOSTANDARD LVCMOS15 [get_ports if2_tx_disable]
set_property PACKAGE_PIN E39 [get_ports if2_tx_fault]
set_property IOSTANDARD LVCMOS15 [get_ports if2_tx_fault]
set_property PACKAGE_PIN J37 [get_ports if2_tx_abs]
set_property IOSTANDARD LVCMOS15 [get_ports if2_tx_abs]
set_property PACKAGE_PIN AY18  [get_ports if2_tx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if2_tx_led]
set_property PACKAGE_PIN AY17  [get_ports if2_rx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if2_rx_led]
set_property LOC GTHE2_CHANNEL_X1Y37 \
  [get_cells -hier -filter name=~*if_2*gthe2_i]

# network interface 3
set_property PACKAGE_PIN L21 [get_ports if3_tx_disable]
set_property IOSTANDARD LVCMOS15 [get_ports if3_tx_disable]
set_property PACKAGE_PIN J26 [get_ports if3_tx_fault]
set_property IOSTANDARD LVCMOS15 [get_ports if3_tx_fault]
set_property PACKAGE_PIN H36 [get_ports if3_tx_abs]
set_property IOSTANDARD LVCMOS15 [get_ports if3_tx_abs]
set_property PACKAGE_PIN P31  [get_ports if3_tx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if3_tx_led]
set_property PACKAGE_PIN K32  [get_ports if3_rx_led]
set_property IOSTANDARD LVCMOS15 [get_ports if3_rx_led]
set_property LOC GTHE2_CHANNEL_X1Y36 \
  [get_cells -hier -filter name=~*if_3*gthe2_i]

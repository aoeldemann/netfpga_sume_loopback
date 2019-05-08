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
# Creates the netfpga_sume_10g_if_shared IP core.

set design netfpga_sume_10g_if_shared
set top netfpga_sume_10g_if_shared

source ../ip_create_start.tcl

read_verilog "./hdl/netfpga_sume_10g_if_shared.v"

ipx::package_project -force -import_files

ipx::infer_bus_interface clk156_out xilinx.com:signal:clock_rtl:1.0 \
  [ipx::current_core]
ipx::infer_bus_interface areset_clk156_out xilinx.com:signal:reset_rtl:1.0 \
  [ipx::current_core]

ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces m_axis -of_objects \
  [ipx::current_core]]
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces s_axis -of_objects \
  [ipx::current_core]]
ipx::add_bus_parameter FREQ_HZ [ipx::get_bus_interfaces clk156_out -of_objects \
  [ipx::current_core]]
set_property value 156250000 [ipx::get_bus_parameters FREQ_HZ -of_objects \
  [ipx::get_bus_interfaces clk156_out -of_objects [ipx::current_core]]]
ipx::add_bus_parameter ASSOCIATED_BUSIF \
  [ipx::get_bus_interfaces clk156_out -of_objects [ipx::current_core]]
set_property value m_axis:s_axis \
  [ipx::get_bus_parameters ASSOCIATED_BUSIF -of_objects \
  [ipx::get_bus_interfaces clk156_out -of_objects [ipx::current_core]]]

source ../ip_create_end.tcl

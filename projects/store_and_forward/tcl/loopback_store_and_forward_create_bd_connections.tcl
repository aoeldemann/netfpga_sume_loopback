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
# Connect block design IP cores.

# connect network interfaces reset
connect_bd_net [get_bd_ports reset] [get_bd_pins if_0/reset]

# connect interfaces rx to frame buffer ip cores
connect_bd_intf_net [get_bd_intf_pins if_0/m_axis] \
  [get_bd_intf_pins frame_buffer_0/s_axis]
connect_bd_intf_net [get_bd_intf_pins if_1/m_axis] \
  [get_bd_intf_pins frame_buffer_1/s_axis]
connect_bd_intf_net [get_bd_intf_pins if_2/m_axis] \
  [get_bd_intf_pins frame_buffer_2/s_axis]
connect_bd_intf_net [get_bd_intf_pins if_3/m_axis] \
  [get_bd_intf_pins frame_buffer_3/s_axis]

# loop back frame buffer ip cores to network interfaces (0 <-> 1, 2 <-> 3)
connect_bd_intf_net [get_bd_intf_pins frame_buffer_0/m_axis] \
  [get_bd_intf_pins if_1/s_axis]
connect_bd_intf_net [get_bd_intf_pins frame_buffer_1/m_axis] \
  [get_bd_intf_pins if_0/s_axis]
connect_bd_intf_net [get_bd_intf_pins frame_buffer_2/m_axis] \
  [get_bd_intf_pins if_3/s_axis]
connect_bd_intf_net [get_bd_intf_pins frame_buffer_3/m_axis] \
  [get_bd_intf_pins if_2/s_axis]

# connect clock and reset of frame buffer ip cores
connect_bd_net [get_bd_pins if_0/clk156_out] [get_bd_pins frame_buffer_0/clk]
connect_bd_net [get_bd_pins if_0/clk156_out] [get_bd_pins frame_buffer_1/clk]
connect_bd_net [get_bd_pins if_0/clk156_out] [get_bd_pins frame_buffer_2/clk]
connect_bd_net [get_bd_pins if_0/clk156_out] [get_bd_pins frame_buffer_3/clk]
connect_bd_net [get_bd_pins if_0/areset_clk156_out] \
  [get_bd_pins frame_buffer_0/rst]
connect_bd_net [get_bd_pins if_0/areset_clk156_out] \
  [get_bd_pins frame_buffer_1/rst]
connect_bd_net [get_bd_pins if_0/areset_clk156_out] \
  [get_bd_pins frame_buffer_2/rst]
connect_bd_net [get_bd_pins if_0/areset_clk156_out] \
  [get_bd_pins frame_buffer_3/rst]

# connect remaining network inferface pins
connect_bd_net [get_bd_ports sfp_clk_n] [get_bd_pins if_0/refclk_n]
connect_bd_net [get_bd_ports sfp_clk_p] [get_bd_pins if_0/refclk_p]
connect_bd_net [get_bd_ports if0_rxn] [get_bd_pins if_0/rxn]
connect_bd_net [get_bd_ports if1_rxn] [get_bd_pins if_1/rxn]
connect_bd_net [get_bd_ports if2_rxn] [get_bd_pins if_2/rxn]
connect_bd_net [get_bd_ports if3_rxn] [get_bd_pins if_3/rxn]
connect_bd_net [get_bd_ports if0_rxp] [get_bd_pins if_0/rxp]
connect_bd_net [get_bd_ports if1_rxp] [get_bd_pins if_1/rxp]
connect_bd_net [get_bd_ports if2_rxp] [get_bd_pins if_2/rxp]
connect_bd_net [get_bd_ports if3_rxp] [get_bd_pins if_3/rxp]
connect_bd_net [get_bd_ports if0_txn] [get_bd_pins if_0/txn]
connect_bd_net [get_bd_ports if1_txn] [get_bd_pins if_1/txn]
connect_bd_net [get_bd_ports if2_txn] [get_bd_pins if_2/txn]
connect_bd_net [get_bd_ports if3_txn] [get_bd_pins if_3/txn]
connect_bd_net [get_bd_ports if0_txp] [get_bd_pins if_0/txp]
connect_bd_net [get_bd_ports if1_txp] [get_bd_pins if_1/txp]
connect_bd_net [get_bd_ports if2_txp] [get_bd_pins if_2/txp]
connect_bd_net [get_bd_ports if3_txp] [get_bd_pins if_3/txp]
connect_bd_net [get_bd_ports if0_tx_abs] [get_bd_pins if_0/tx_abs]
connect_bd_net [get_bd_ports if1_tx_abs] [get_bd_pins if_1/tx_abs]
connect_bd_net [get_bd_ports if2_tx_abs] [get_bd_pins if_2/tx_abs]
connect_bd_net [get_bd_ports if3_tx_abs] [get_bd_pins if_3/tx_abs]
connect_bd_net [get_bd_ports if0_tx_fault] [get_bd_pins if_0/tx_fault]
connect_bd_net [get_bd_ports if1_tx_fault] [get_bd_pins if_1/tx_fault]
connect_bd_net [get_bd_ports if2_tx_fault] [get_bd_pins if_2/tx_fault]
connect_bd_net [get_bd_ports if3_tx_fault] [get_bd_pins if_3/tx_fault]
connect_bd_net [get_bd_ports if0_rx_led] [get_bd_pins if_0/resetdone]
connect_bd_net [get_bd_ports if0_tx_led] [get_bd_pins if_0/resetdone]
connect_bd_net [get_bd_ports if1_rx_led] [get_bd_pins if_1/rx_resetdone]
connect_bd_net [get_bd_ports if1_tx_led] [get_bd_pins if_1/tx_resetdone]
connect_bd_net [get_bd_ports if2_rx_led] [get_bd_pins if_2/rx_resetdone]
connect_bd_net [get_bd_ports if2_tx_led] [get_bd_pins if_2/tx_resetdone]
connect_bd_net [get_bd_ports if3_rx_led] [get_bd_pins if_3/rx_resetdone]
connect_bd_net [get_bd_ports if3_tx_led] [get_bd_pins if_3/tx_resetdone]
connect_bd_net [get_bd_ports if0_tx_disable] [get_bd_pins if_0/tx_disable]
connect_bd_net [get_bd_ports if1_tx_disable] [get_bd_pins if_1/tx_disable]
connect_bd_net [get_bd_ports if2_tx_disable] [get_bd_pins if_2/tx_disable]
connect_bd_net [get_bd_ports if3_tx_disable] [get_bd_pins if_3/tx_disable]
connect_bd_net [get_bd_pins if_0/clk156_out] [get_bd_pins if_1/clk156]
connect_bd_net [get_bd_pins if_0/clk156_out] [get_bd_pins if_2/clk156]
connect_bd_net [get_bd_pins if_0/clk156_out] [get_bd_pins if_3/clk156]
connect_bd_net [get_bd_pins if_0/areset_clk156_out] \
  [get_bd_pins if_1/areset_clk156]
connect_bd_net [get_bd_pins if_0/areset_clk156_out] \
  [get_bd_pins if_2/areset_clk156]
connect_bd_net [get_bd_pins if_0/areset_clk156_out] \
  [get_bd_pins if_3/areset_clk156]
connect_bd_net [get_bd_pins if_0/gtrxreset_out] [get_bd_pins if_1/gtrxreset]
connect_bd_net [get_bd_pins if_0/gtrxreset_out] [get_bd_pins if_2/gtrxreset]
connect_bd_net [get_bd_pins if_0/gtrxreset_out] [get_bd_pins if_3/gtrxreset]
connect_bd_net [get_bd_pins if_0/gttxreset_out] [get_bd_pins if_1/gttxreset]
connect_bd_net [get_bd_pins if_0/gttxreset_out] [get_bd_pins if_2/gttxreset]
connect_bd_net [get_bd_pins if_0/gttxreset_out] [get_bd_pins if_3/gttxreset]
connect_bd_net [get_bd_pins if_0/qplllock_out] [get_bd_pins if_1/qplllock]
connect_bd_net [get_bd_pins if_0/qplllock_out] [get_bd_pins if_2/qplllock]
connect_bd_net [get_bd_pins if_0/qplllock_out] [get_bd_pins if_3/qplllock]
connect_bd_net [get_bd_pins if_0/qplloutclk_out] [get_bd_pins if_1/qplloutclk]
connect_bd_net [get_bd_pins if_0/qplloutclk_out] [get_bd_pins if_2/qplloutclk]
connect_bd_net [get_bd_pins if_0/qplloutclk_out] [get_bd_pins if_3/qplloutclk]
connect_bd_net [get_bd_pins if_0/qplloutrefclk_out] \
  [get_bd_pins if_1/qplloutrefclk]
connect_bd_net [get_bd_pins if_0/qplloutrefclk_out] \
  [get_bd_pins if_2/qplloutrefclk]
connect_bd_net [get_bd_pins if_0/qplloutrefclk_out] \
  [get_bd_pins if_3/qplloutrefclk]
connect_bd_net [get_bd_pins if_0/txuserrdy_out] [get_bd_pins if_1/txuserrdy]
connect_bd_net [get_bd_pins if_0/txuserrdy_out] [get_bd_pins if_2/txuserrdy]
connect_bd_net [get_bd_pins if_0/txuserrdy_out] [get_bd_pins if_3/txuserrdy]
connect_bd_net [get_bd_pins if_0/txusrclk_out] [get_bd_pins if_1/txusrclk]
connect_bd_net [get_bd_pins if_0/txusrclk_out] [get_bd_pins if_2/txusrclk]
connect_bd_net [get_bd_pins if_0/txusrclk_out] [get_bd_pins if_3/txusrclk]
connect_bd_net [get_bd_pins if_0/txusrclk2_out] [get_bd_pins if_1/txusrclk2]
connect_bd_net [get_bd_pins if_0/txusrclk2_out] [get_bd_pins if_2/txusrclk2]
connect_bd_net [get_bd_pins if_0/txusrclk2_out] [get_bd_pins if_3/txusrclk2]
connect_bd_net [get_bd_pins if_0/reset_counter_done_out] \
  [get_bd_pins if_1/reset_counter_done]
connect_bd_net [get_bd_pins if_0/reset_counter_done_out] \
  [get_bd_pins if_2/reset_counter_done]
connect_bd_net [get_bd_pins if_0/reset_counter_done_out] \
  [get_bd_pins if_3/reset_counter_done]

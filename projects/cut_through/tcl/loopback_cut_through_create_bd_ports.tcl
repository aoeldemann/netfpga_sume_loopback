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
# Creates block design ports.

# SFP_CLK (156.25 MHz)
create_bd_port -dir I -type clk sfp_clk_p
create_bd_port -dir I -type clk sfp_clk_n

# fpga reset
create_bd_port -dir I -type rst reset
set_property -dict [list CONFIG.POLARITY {ACTIVE_HIGH}] [get_bd_ports reset]

# network if 0
create_bd_port -dir O if0_rx_led
create_bd_port -dir O if0_tx_led
create_bd_port -dir I if0_tx_abs
create_bd_port -dir I if0_tx_fault
create_bd_port -dir O if0_tx_disable
create_bd_port -dir I if0_rxn
create_bd_port -dir I if0_rxp
create_bd_port -dir O if0_txn
create_bd_port -dir O if0_txp

# network if 1
create_bd_port -dir O if1_rx_led
create_bd_port -dir O if1_tx_led
create_bd_port -dir I if1_tx_abs
create_bd_port -dir I if1_tx_fault
create_bd_port -dir O if1_tx_disable
create_bd_port -dir I if1_rxn
create_bd_port -dir I if1_rxp
create_bd_port -dir O if1_txn
create_bd_port -dir O if1_txp

# network if 2
create_bd_port -dir O if2_rx_led
create_bd_port -dir O if2_tx_led
create_bd_port -dir I if2_tx_abs
create_bd_port -dir I if2_tx_fault
create_bd_port -dir O if2_tx_disable
create_bd_port -dir I if2_rxn
create_bd_port -dir I if2_rxp
create_bd_port -dir O if2_txn
create_bd_port -dir O if2_txp

# network if 3
create_bd_port -dir O if3_rx_led
create_bd_port -dir O if3_tx_led
create_bd_port -dir I if3_tx_abs
create_bd_port -dir I if3_tx_fault
create_bd_port -dir O if3_tx_disable
create_bd_port -dir I if3_rxn
create_bd_port -dir I if3_rxp
create_bd_port -dir O if3_txn
create_bd_port -dir O if3_txp

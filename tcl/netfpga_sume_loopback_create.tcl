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
# Creates Vivado project.

# set some basic project infos
set design netfpga_sume_loopback
set device xc7vx690t-3-ffg1761
set proj_dir ./project
set repo_dir ./ip

# set current directory
set current_dir [pwd]

# create the project
create_project -name ${design} -force -dir "./${proj_dir}" -part ${device}
set_property source_mgmt_mode DisplayOnly [current_project]

# set ip repo directory
set_property ip_repo_paths ${repo_dir} [current_fileset]

# update ip catalog
update_ip_catalog

# create block design
create_bd_design ${design}

# import constaint files
add_files -fileset constrs_1 -norecurse ./xdc/${design}_bd.xdc
import_files -fileset constrs_1 ./xdc/${design}_bd.xdc

# create xilinx ip cores used by project's ip cores
source ./tcl/${design}_create_ip.tcl

# instantiate network interface cores
create_bd_cell -type ip -vlnv TUMLIS:TUMLIS:netfpga_sume_10g_if_shared:1.00 if_0
create_bd_cell -type ip -vlnv TUMLIS:TUMLIS:netfpga_sume_10g_if:1.00 if_1
create_bd_cell -type ip -vlnv TUMLIS:TUMLIS:netfpga_sume_10g_if:1.00 if_2
create_bd_cell -type ip -vlnv TUMLIS:TUMLIS:netfpga_sume_10g_if:1.00 if_3

# create external ports
source ./tcl/${design}_create_bd_ports.tcl

# create connections
source ./tcl/${design}_create_bd_connections.tcl

# save block design
current_bd_instance [current_bd_instance .]
save_bd_design

# create system block
make_wrapper -files \
  [get_files ./${proj_dir}/${design}.srcs/sources_1/bd/${design}/${design}.bd] \
  -top
add_files -norecurse \
  ./${proj_dir}/${design}.srcs/sources_1/bd/${design}/hdl/${design}_wrapper.v

# set toplevel module
set_property top ${design}_wrapper [current_fileset]

# done
exit

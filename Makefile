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
# Makefile to build hardware components

.PHONY: all ip project synth impl program clean clean-ip

all:
	@echo "Targets:"
	@echo " - ip"
	@echo " - project"
	@echo " - synth"
	@echo " - impl"
	@echo " - program"
	@echo " - clean"
	@echo " - clean-ip"

ip:
	for ip in ip/netfpga_sume_10g_if*; do make -C $${ip}; done

project:
	if ! test -f ip/netfpga_sume_10g_if/component.xml; then\
		echo "ERROR: please create netfpga_sume_10g_if ip core first";\
	elif ! test -f ip/netfpga_sume_10g_if_shared/component.xml; then\
		echo "ERROR: please create netfpga_sume_10g_if_shared ip core first";\
	elif test -d project; then\
		echo "ERROR: project already exists";\
	else \
		vivado -mode batch -source tcl/netfpga_sume_loopback_create.tcl;\
	fi;\

synth:
	if ! test -d project/; then\
		echo "ERROR: project does not exist";\
	fi;\
	vivado -mode batch -source tcl/netfpga_sume_loopback_synth.tcl

impl:
	if ! test -d project/; then\
		echo "ERROR: project does not exist";\
	fi;\
	vivado -mode batch -source tcl/netfpga_sume_loopback_impl.tcl


program:
	if ! test -f project/netfpga_sume_loopback.runs/impl_1/netfpga_sume_loopback_wrapper.bit; then\
		echo "ERROR: bitstream does not exist";\
	else \
		xsdb tcl/netfpga_sume_loopback_program.tcl;\
	fi;\

clean:
	rm -rf project/ vivado* .Xil/ ip_repo/

clean-ip:
	for ip in ip/*; do make -C $${ip} clean; done

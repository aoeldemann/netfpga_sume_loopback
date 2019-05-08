# NetFPGA-SUME Network Interface Loopback Design

A hardware design for the NetFPGA-SUME, which loops-back the AXI-Stream TX and
RX interfaces of the Ethernet MACs.

## Loopback Connections

- Port 0 RX -> Port 1 TX
- Port 1 RX -> Port 0 TX
- Port 2 RX -> Port 3 TX
- Port 3 RX -> Port 2 TX

## Xilinx Vivado Version

Design implemented and tested using Xilinx Vivado 2018.3.


## Bitstream Generation

```
make ip
make project
make synth
make impl
```

Bitstream: `find . -name "*.bit"`

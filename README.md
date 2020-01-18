# NetFPGA SUME Network Interface Loopback Design

A hardware design for the NetFPGA SUME, which loops-back the AXI-Stream RX and
TX interfaces of the Ethernet MACs. Comes in two flavors: cut-through and
store-and-forward.

## Cut-Through Design

**Location:** `projects/cut_through/`

The AXI-Stream RX interfaces are directly connected to the TX interfaces.

## Store-and-Forward Design

**Location:** `projects/store_and_forward`

Frames received on the AXI-Stream interfaces from the MAC are placed in a small FIFO and only transmitted back for tranmission on the network when comeplely
received. Frames, which are invalid (e.g., too small, bad FCS), are discarded.

## Loopback Connections

- Port 0 RX -> Port 1 TX
- Port 1 RX -> Port 0 TX
- Port 2 RX -> Port 3 TX
- Port 3 RX -> Port 2 TX

## Xilinx Vivado Version

Design implemented and tested using Xilinx Vivado 2019.1.


## Bitstream Generation

### Step 1: Build IP Cores

```bash
make -C ip/
```

### Step 2: Synthezise and Implement

Change into one of the project directory:


```bash
cd projects/cut_through/
```
or
```bash
cd projects/store_and_forward/
```

Then create the project, perform synthesis and finally implementation:

```bash
make project && make synth && make impl
```

Determine the location of the generated bitstream:

```bash
find . -name "*.bit"
```

# AXI master IP SV testbench
Testbench, using SVA, for AXI master IP from Open-Logic library ([https://github.com/open-logic]). 

## Introduction
SVA assertions bring a special kind of joy to RTL verification. It's like setting up a series of watchdogs in your design, constantly monitoring for any behavior that deviates from your expectations. With SVAs, you can precisely define complex temporal relationships and corner cases, ensuring that your design behaves exactly as intended. The satisfaction of seeing those assertions pass, knowing that your logic is rock solid, is unmatched. Plus, when an assertion fails, it provides laser-focused debugging information, saving you countless hours of sifting through waveforms. SVAs are a verification engineer's secret weapon, bringing a sense of confidence and control to the often chaotic world of RTL design.

## Description

### AXI master IP
The provided DUT entity implements a complete AXI master supporting both read and write operations.
[https://github.com/open-logic/open-logic/blob/main/src/axi/vhdl/olo_axi_master_full.vhd]

* Unaligned Transfers: A key feature is its ability to handle unaligned transfers, meaning data transfers don't need to start at addresses that are multiples of the AXI data width. This adds flexibility but comes with a slight performance overhead for very small transfers.

* Data Width Conversion: It supports different data widths for the AXI bus and the user interface. The AXI interface can be wider than the user interface, allowing for efficient data transfer on the AXI bus while accommodating different user data widths.
Generics for Customization: The code uses generics to configure various parameters like address width, data width, maximum number of beats, and FIFO depth, making it adaptable to different system requirements.

* Internal FIFOs: It utilizes FIFOs for buffering write data, which helps to smooth out data flow and handle potential stalls in the AXI bus.

* Flow Control: The code incorporates flow control mechanisms to ensure proper handshaking and data transfer between the user interface and the AXI bus.

* Error Handling: It includes basic error handling by providing Wr_Error and Rd_Error signals to indicate potential issues during write and read operations.

#### Implementation Details

* Finite State Machines (FSMs): The code uses multiple FSMs to manage the different stages of read and write operations, including command processing, data alignment, and data transfer.
  
* Address Alignment: It includes a function AlignedAddr_f to calculate the aligned AXI address for unaligned user requests.
  
* Byte Enables: It carefully manages byte enables (Wr_Be, Rd_Be) to handle partial word transfers during unaligned operations.
  
* Two-Process Model: The code follows a common VHDL coding style with two processes: a combinatorial process for calculating next-state logic and an asynchronous process for register updates.

## Testbench description
### Write operation
Assertions verify that the AXI write address channel signals are correct for a single write operation:

* m_axi_awaddr == 32'h1000: Checks that the address on the AXI write address channel (m_axi_awaddr) matches the address sent to the master (32'h1000).
* m_axi_awlen == 8'd0: Verifies that the burst length is 0, as this is a single beat (non-burst) transfer.
* m_axi_awsize == 3'b010: Checks that the transfer size is set to 4 bytes (3'b010 corresponds to 4 bytes in AXI).
* m_axi_awburst == 2'b00: Confirms that the burst type is fixed, which is the typical type for single transfers.
* m_axi_wdata == 32'hABCDEF01: Checks that the write data on the AXI write data channel matches the data provided to the master (32'hABCDEF01).
* m_axi_wstrb == 4'b1111: Verifies that all byte lanes are enabled for the write, as we are writing 4 bytes.
* m_axi_wlast == 1'b1: Confirms that the m_axi_wlast signal is asserted, indicating the last beat of the write transaction (since it's a single beat).
If any of these assertions fail, the $error system task will be called, displaying the corresponding error message and stopping the simulation.

### Read operation
Similar to the write assertions but focus on the AXI read address channel signals (m_axi_araddr, m_axi_arlen, etc.) to ensure they are set correctly for a single read operation.

## Key Concepts in the Assertions:

* AXI Channels: The assertions specifically target the AXI address and data channels (AW, W, AR, R) to verify the control and data flow.
* Burst Operations: The m_axi_awlen and m_axi_arlen signals are checked to differentiate between single and burst transfers.
* Data Size: m_axi_awsize and m_axi_arsize are verified to ensure the correct data size is being used for the transfers.
* Byte Enables: m_axi_wstrb is checked to ensure the correct bytes are being written.
* Last Beat Indication: m_axi_wlast is asserted for the last beat of a write transaction. (Similarly, m_axi_rlast would be checked for read transactions).
  
By using these assertions, the testbench can automatically detect errors in the AXI master's behavior, helping you to quickly identify and debug any issues in your design.

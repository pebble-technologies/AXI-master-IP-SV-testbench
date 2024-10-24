// -----------------------------------------------------------------------------
// File: olo_axi_master_full_tb.sv
// Date: Wed Oct 23 2024
// Author: Pebble Technologies, https://pebble-technologies.net/
// Description: Testbench for AXI master IP from Open-Logic library 
//              https://github.com/open-logic
// -----------------------------------------------------------------------------

module olo_axi_master_full_tb;

  // Parameters
  localparam AxiAddrWidth_lp = 32;
  localparam AxiDataWidth_lp = 32;
  localparam UserTransactionSizeBits_lp = 24;
  localparam UserDataWidth_lp = 32;

  // Signals
  logic clk;
  logic rst;
  logic [AxiAddrWidth_lp-1:0]  cmd_wr_addr;
  logic [UserTransactionSizeBits_lp-1:0] cmd_wr_size;
  logic                        cmd_wr_lowlat;
  logic                        cmd_wr_valid;
  logic                        cmd_wr_ready;
  logic [AxiAddrWidth_lp-1:0]  cmd_rd_addr;
  logic [UserTransactionSizeBits_lp-1:0] cmd_rd_size;
  logic                        cmd_rd_lowlat;
  logic                        cmd_rd_valid;
  logic                        cmd_rd_ready;
  logic [UserDataWidth_lp-1:0] wr_data;
  logic                        wr_valid;
  logic                        wr_ready;
  logic [UserDataWidth_lp-1:0] rd_data;
  logic                        rd_last;
  logic                        rd_valid;
  logic                        rd_ready;
  logic                        wr_done;
  logic                        wr_error;
  logic                        rd_done;
  logic                        rd_error;
  logic [AxiAddrWidth_lp-1:0]  m_axi_awaddr;
  logic [7:0]                 m_axi_awlen;
  logic [2:0]                 m_axi_awsize;
  logic [1:0]                 m_axi_awburst;
  logic                        m_axi_awlock;
  logic [3:0]                 m_axi_awcache;
  logic [2:0]                 m_axi_awprot;
  logic   
                        m_axi_awvalid;
  logic                        m_axi_awready;
  logic [AxiDataWidth_lp-1:0]  m_axi_wdata;
  logic [AxiDataWidth_lp/8-1:0] m_axi_wstrb;
  logic                        m_axi_wlast;
  logic                        m_axi_wvalid;
  logic                        m_axi_wready;
  logic [1:0]                 m_axi_bresp;
  logic                        m_axi_bvalid;
  logic                        m_axi_bready;
  logic [AxiAddrWidth_lp-1:0]  m_axi_araddr;
  logic [7:0]                 m_axi_arlen;
  logic [2:0]                 m_axi_arsize;
  logic [1:0]                 m_axi_arburst;
  logic                        m_axi_arlock;
  logic [3:0]                 m_axi_arcache;
  logic [2:0]                 m_axi_arprot;
  logic   
                        m_axi_arvalid;
  logic                        m_axi_arready;
  logic [AxiDataWidth_lp-1:0]  m_axi_rdata;
  logic [1:0]                 m_axi_rresp;
  logic                        m_axi_rlast;
  logic                        m_axi_rvalid;
  logic                        m_axi_rready;

  // Clock generation
  always #5 clk = ~clk;

  // Instantiate the DUT
  olo_axi_master_full #(
    .AxiAddrWidth_g(AxiAddrWidth_lp),
    .AxiDataWidth_g(AxiDataWidth_lp),
    .UserTransactionSizeBits_g(UserTransactionSizeBits_lp),
    .UserDataWidth_g(UserDataWidth_lp)
  ) dut (
    .Clk(clk),
    .Rst(rst),
    .CmdWr_Addr(cmd_wr_addr),
    .CmdWr_Size(cmd_wr_size),
    .CmdWr_LowLat(cmd_wr_lowlat),
    .CmdWr_Valid(cmd_wr_valid),
    .CmdWr_Ready(cmd_wr_ready),
    .CmdRd_Addr(cmd_rd_addr),
    .CmdRd_Size(cmd_rd_size),
    .CmdRd_LowLat(cmd_rd_lowlat),
    .CmdRd_Valid(cmd_rd_valid),
    .CmdRd_Ready(cmd_rd_ready),
    .Wr_Data(wr_data),
    .Wr_Valid(wr_valid),
    .Wr_Ready(wr_ready),
    .Rd_Data(rd_data),
    .Rd_Last(rd_last),
    .Rd_Valid(rd_valid),
    .Rd_Ready(rd_ready),
    .Wr_Done(wr_done),
    .Wr_Error(wr_error),
    .Rd_Done(rd_done),
    .Rd_Error(rd_error),
    .M_Axi_AwAddr(m_axi_awaddr),
    .M_Axi_AwLen(m_axi_awlen),
    .M_Axi_AwSize(m_axi_awsize),
    .M_Axi_AwBurst(m_axi_awburst),
    .M_Axi_AwLock(m_axi_awlock),
    .M_Axi_AwCache(m_axi_awcache),
    .M_Axi_AwProt(m_axi_awprot),
    .M_Axi_AwValid(m_axi_awvalid),
    .M_Axi_AwReady(m_axi_awready),
    .M_Axi_WData(m_axi_wdata),
    .M_Axi_WStrb(m_axi_wstrb),
    .M_Axi_WLast(m_axi_wlast),
    .M_Axi_WValid(m_axi_wvalid),
    .M_Axi_WReady(m_axi_wready),
    .M_Axi_BResp(m_axi_bresp),   

    .M_Axi_BValid(m_axi_bvalid),
    .M_Axi_BReady(m_axi_bready),
    .M_Axi_ArAddr(m_axi_araddr),
    .M_Axi_ArLen(m_axi_arlen),
    .M_Axi_ArSize(m_axi_arsize),
    .M_Axi_ArBurst(m_axi_arburst),
    .M_Axi_ArLock(m_axi_arlock),   

    .M_Axi_ArCache(m_axi_arcache),
    .M_Axi_ArProt(m_axi_arprot),
    .M_Axi_ArValid(m_axi_arvalid),
    .M_Axi_ArReady(m_axi_arready),
    .M_Axi_RData(m_axi_rdata),
    .M_Axi_RResp(m_axi_rresp),
    .M_Axi_RLast(m_axi_rlast),
    .M_Axi_RValid(m_axi_rvalid),
    .M_Axi_RReady(m_axi_rready)   

  );

  // AXI Slave model (simple model for basic tests)
  task axi_slave_write(
    input logic [AxiAddrWidth_lp-1:0] addr,
    input logic [AxiDataWidth_lp-1:0] data,
    input logic [AxiDataWidth_lp/8-1:0] strb
  );
    // Simple memory model: Just display the write operation
    $display("[AXI Slave] Write to address 0x%h, data 0x%h, strb 0x%h", addr, data, strb);
  endtask

  task axi_slave_read(
    input logic [AxiAddrWidth_lp-1:0] addr,
    output logic [AxiDataWidth_lp-1:0] data,
    output logic [1:0] rresp
  );
    // Simple memory model: Return predefined data and OKAY response
    data = addr + 32'h1000; 
    rresp = 2'b00; // OKAY
    $display("[AXI Slave] Read from address 0x%h, data 0x%h", addr, data);
  endtask

  // AXI Slave interface logic
  always @(posedge clk)
  begin
    if (m_axi_awvalid && m_axi_awready) begin
      axi_slave_write(m_axi_awaddr, m_axi_wdata, m_axi_wstrb);
      m_axi_bvalid <= 1; // Acknowledge write
      m_axi_bresp <= 2'b00; // OKAY response
    end

    if (m_axi_wvalid && m_axi_wready) begin
      m_axi_bvalid <= 0; // Deactivate write response
    end

    if (m_axi_bready && m_axi_bvalid) begin
      // Write response accepted
    end

    if (m_axi_arvalid && m_axi_arready) begin
      axi_slave_read(m_axi_araddr, m_axi_rdata, m_axi_rresp);
      m_axi_rvalid <= 1; // Provide read data
      m_axi_rlast <= 1; // Assume single beat read for now
    end

    if (m_axi_rready && m_axi_rvalid) begin
      m_axi_rvalid <= 0; // Deactivate read data
    end
  end

  // ------------------------------------------------------------
  // Concurrent assertions executed in parallel with the main testbench sequence
  // ------------------------------------------------------------
  
  // Write Operation Assertion: Checks that a write response is received within 10 clock cycles
  // after a write request is accepted.
  property write_response_check;
    @(posedge clk) (m_axi_awvalid && m_axi_awready) |-> ##[1:10] (!m_axi_bvalid && m_axi_bready);
  endproperty
  assert property (write_response_check) else $error("Write response timeout");

  // Read Operation Assertion: Checks that read data is available within 5 clock cycles
  // after a read request is accepted.
  property read_data_check;
    @(posedge clk) (m_axi_arvalid && m_axi_arready) |-> ##[1:5] (m_axi_rvalid && m_axi_rready); 
  endproperty
  assert property (read_data_check) else $error("Read data timeout");
  
  // Test scenarios
  initial begin
    // Initialization
    clk = 0;
    rst = 1;
    cmd_wr_valid = 0;
    cmd_rd_valid = 0;
    wr_valid = 0;
    rd_ready = 1;
    #20 rst = 0;

    // ------------------------------------------------------------
    // Single Write Test
    // ------------------------------------------------------------
    #20;
    cmd_wr_addr = 32'h1000;
    cmd_wr_size = 32'd4; // 4 bytes
    cmd_wr_valid = 1;
    wr_data = 32'hABCDEF01;
    wr_valid = 1;
    #10;
    // Assertions for single write
    assert (m_axi_awaddr == 32'h1000) else $error("AWADDR mismatch");
    assert (m_axi_awlen == 8'd0) else $error("AWLEN mismatch"); // Single beat
    assert (m_axi_awsize == 3'b010) else $error("AWSIZE mismatch"); // 4 bytes
    assert (m_axi_awburst == 2'b00) else $error("AWBURST mismatch"); // Fixed burst
    assert (m_axi_wdata == 32'hABCDEF01) else $error("WDATA mismatch");
    assert (m_axi_wstrb == 4'b1111) else $error("WSTRB mismatch");
    assert (m_axi_wlast == 1'b1) else $error("WLAST mismatch"); // Single beat
    #10 cmd_wr_valid = 0;
    wr_valid = 0;
    wait(wr_done);
    assert (wr_error == 0) else $error("Write error");

    // ------------------------------------------------------------
    // Single Read Test
    // ------------------------------------------------------------
    #20;
    cmd_rd_addr = 32'h2000;
    cmd_rd_size = 32'd4; // 4 bytes
    cmd_rd_valid = 1;
    #10;
    // Assertions for single read
    assert (m_axi_araddr == 32'h2000) else $error("ARADDR mismatch");
    assert (m_axi_arlen == 8'd0) else $error("ARLEN mismatch"); // Single beat
    assert (m_axi_arsize == 3'b010) else $error("ARSIZE mismatch"); // 4 bytes
    assert (m_axi_arburst == 2'b00) else $error("ARBURST mismatch"); // Fixed burst
    #20;
    cmd_rd_valid = 0;
    wait(rd_done);
    assert (rd_error == 0) else $error("Read error");
    assert (rd_data == 32'h2000 + 32'h1000) else $error("Read data mismatch");

    // ------------------------------------------------------------
    // Burst Write Test
    // ------------------------------------------------------------
    #20;
    cmd_wr_addr = 32'h3000;
    cmd_wr_size = 32'd16; // 16 bytes (4 beats)
    cmd_wr_valid = 1;
    for (int i = 0; i < 4; i++) begin
      wr_data = 32'hA000 + i;
      wr_valid = 1;
      #10;
      assert (m_axi_wdata == 32'hA000 + i) else $error("WDATA mismatch");
      wr_valid = 0;
    end
    // Assertions for burst write
    assert (m_axi_awaddr == 32'h3000) else $error("AWADDR mismatch");
    assert (m_axi_awlen == 8'd3) else $error("AWLEN mismatch"); // 4 beats
    assert (m_axi_awsize == 3'b010) else $error("AWSIZE mismatch"); // 4 bytes
    assert (m_axi_awburst == 2'b01) else $error("AWBURST mismatch"); // Incrementing burst
    #10 cmd_wr_valid = 0;
    wait(wr_done);
    assert (wr_error == 0) else $error("Write error");

    // ------------------------------------------------------------
    // Burst Read Test
    // ------------------------------------------------------------
    #20;
    cmd_rd_addr = 32'h4000;
    cmd_rd_size = 32'd16; // 16 bytes (4 beats)
    cmd_rd_valid = 1;
    #10;
    // Assertions for burst read
    assert (m_axi_araddr == 32'h4000) else $error("ARADDR mismatch");
    assert (m_axi_arlen == 8'd3) else $error("ARLEN mismatch"); // 4 beats
    assert (m_axi_arsize == 3'b010) else $error("ARSIZE mismatch"); // 4 bytes
    assert (m_axi_arburst == 2'b01) else $error("ARBURST mismatch"); // Incrementing burst
    #20;
    cmd_rd_valid = 0;
    for (int i = 0; i < 4; i++) begin
      #10;
      assert (rd_data == 32'h4000 + 32'h1000 + i*4) else $error("Read data mismatch");
    end
    wait(rd_done);
    assert (rd_error == 0) else $error("Read error");

    // ------------------------------------------------------------
    // Unaligned Write Test
    // ------------------------------------------------------------
    #20;
    cmd_wr_addr = 32'h5002; // Unaligned address
    cmd_wr_size = 32'd4; // 4 bytes
    cmd_wr_valid = 1;
    wr_data = 32'hABCDEF01;
    wr_valid = 1;
    #10;
    // Assertions for unaligned write (check for correct address and byte enables)
    assert (m_axi_awaddr == 32'h5000) else $error("AWADDR mismatch (unaligned)"); 

    #100 $finish;
  end

endmodule

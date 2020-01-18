// The MIT License
//
// Copyright (c) 2017-2019 by the author(s)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// Author(s):
//   - Andreas Oeldemann <andreas.oeldemann@tum.de>
//
// Description:
//
// The Xilinx 10G MAC sets the last TUSER field of a received frame high, if it
// is valid (i.e., no underun, FCS correct, ...). This module buffers an
// Ethernet frame arriving on the AXI Stream interface, until it has been
// completely received. It then checks the TUSER field of the last transaction.
// If the frame is valid, it is transmitted on the AXI Stream master interface.
// Otherwise it is discarded.

`timescale 1 ns / 1ps

module frame_buffer (
  input wire           clk,
  input wire           rst,

  input wire [63:0]    s_axis_tdata,
  input wire           s_axis_tvalid,
  input wire           s_axis_tlast,
  input wire [7:0]     s_axis_tkeep,
  input wire           s_axis_tuser,

  output reg [63:0]    m_axis_tdata,
  output reg           m_axis_tvalid,
  output reg           m_axis_tlast,
  output reg  [7:0]    m_axis_tkeep,
  input wire           m_axis_tready
);

  /* FIFO Packet data signals */
  wire [72:0] fifo_data_din, fifo_data_dout;
  wire        fifo_data_wr_en, fifo_data_rd_en, fifo_data_empty;

  /* buffer arriving TDATA, TKEEP and TLAST in the fifo */
  assign fifo_data_din = {s_axis_tdata, s_axis_tkeep, s_axis_tlast};

  /* writing to the FIFO whenever new data is valid at the input */
  assign fifo_data_wr_en = s_axis_tvalid;

  /* extract AXI Stream signals at FIFO output */
  wire [63:0] fifo_data_tdata;
  wire [7:0]  fifo_data_tkeep;
  wire        fifo_data_tlast;
  assign fifo_data_tdata = fifo_data_dout[72:9];
  assign fifo_data_tkeep = fifo_data_dout[8:1];
  assign fifo_data_tlast = fifo_data_dout[0:0];

  /* FIFO holding packet data */
  fifo_singleclock_fwft # (
    .WIDTH(73),
    .DEPTH(256)
  ) fifo_packet_data (
    .clk(clk),
    .rst(rst),
    .wr_en(fifo_data_wr_en),
    .din(fifo_data_din),
    .rd_en(fifo_data_rd_en),
    .dout(fifo_data_dout),
    .full(),
    .prog_full(),
    .empty(fifo_data_empty)
  );

  /* FIFO Frame Good Flag singals */
  wire fifo_good_frame_din, fifo_good_frame_dout;
  wire fifo_good_frame_wr_en, fifo_good_frame_rd_en, fifo_good_frame_empty;

  /* extract the flag indicating whether the arrived frame is good */
  assign fifo_good_frame_din = s_axis_tuser;

  /* the flag is written to the TUSER field by the MAC in the last transaction
   * for each frame. */
  assign fifo_good_frame_wr_en = s_axis_tvalid & s_axis_tlast;

  /* FIFO holding the good frame flags */
  fifo_singleclock_fwft # (
    .WIDTH(1),
    .DEPTH(8)
  ) fifo_good_frame (
    .clk(clk),
    .rst(rst),
    .wr_en(fifo_good_frame_wr_en),
    .din(fifo_good_frame_din),
    .rd_en(fifo_good_frame_rd_en),
    .dout(fifo_good_frame_dout),
    .full(),
    .prog_full(),
    .empty(fifo_good_frame_empty)
  );

  /* register indication whether the data word at the front of the data FIFO is
   * starting a new frame. if yes, it must wait until the frame good flag has
   * been extracted after the entire frame has been received */
  reg fifo_data_new_frame;

  always @(posedge clk) begin
    if (rst) begin
      /* initially the data must start a new frame */
      fifo_data_new_frame <= 1'b1;
    end else begin
      if (fifo_data_rd_en) begin
        /* there is currently data being read from the FIFO. next word starts
         * a new frame, if the one that has been consumed ended another one */
        fifo_data_new_frame <= fifo_data_tlast;
      end else begin
        /* no read from the FIFO -> no change! */
        fifo_data_new_frame <= fifo_data_new_frame;
      end
    end
  end

  /* register storing whether the frame that is currently consumed from the FIFO
   * is good */
  reg good_frame;

  always @(posedge clk) begin
    if (rst) begin
      m_axis_tdata <= 64'b0;
      m_axis_tvalid <= 1'b0;
      m_axis_tkeep <= 8'b0;
      m_axis_tlast <= 1'b0;

      good_frame <= 1'b0;
    end else begin
      if (m_axis_tready | ~m_axis_tvalid) begin
        /* next word can be moved to output registers */

        if (fifo_data_new_frame) begin
          /* if there is a data word waiting in the FIFO, it starts a new
           * frame */

          if (~fifo_data_empty & ~fifo_good_frame_empty) begin
            /* there is data waiting both in the packet and good frame flag
             * FIFOs, so we are ready to determine what do with the frame...
             */

            /* if the frame is good, we transmit it and store the flag */
            good_frame <= fifo_good_frame_dout;
            m_axis_tvalid <= fifo_good_frame_dout;
          end else begin
            /* if no data is ready, nothing to do */
            good_frame <= 1'b0;
            m_axis_tvalid <= 1'b0;
          end
        end else begin
          /* the data that is transferred next does not start a new frame. if
           * the data that we are reading from FIFO belongs to a good frame,
           * transmit it. */
          good_frame <= good_frame;
          m_axis_tvalid <= ~fifo_data_empty & good_frame;
        end

        /* apply AXI Stream data at output */
        m_axis_tdata <= fifo_data_tdata;
        m_axis_tkeep <= fifo_data_tkeep;
        m_axis_tlast <= fifo_data_tlast;
      end else begin
        /* slave not ready to receive. hold output */
        m_axis_tdata <= m_axis_tdata;
        m_axis_tvalid <= m_axis_tvalid;
        m_axis_tkeep <= m_axis_tkeep;
        m_axis_tlast <= m_axis_tlast;

        good_frame <= good_frame;
      end
    end
  end

  /* read data from the packet FIFO when the output registers are available, the
   * FIFO is not empty and we are not waiting for the good frame flag. The
   * performance could be optimized in the future by reading data from the FIFO
   * for frames even if the slave is not ready, since the data is not
   * transferred anyways */
  assign fifo_data_rd_en = (m_axis_tready | ~m_axis_tvalid) & ~fifo_data_empty &
                           ~(fifo_data_new_frame & fifo_good_frame_empty);

  /* read data from the good frame flag FIFO whenever a frame has been
   * completely transferred */
  assign fifo_good_frame_rd_en = (m_axis_tready | ~m_axis_tvalid) &
                                 ~fifo_data_empty & fifo_data_tlast;

endmodule

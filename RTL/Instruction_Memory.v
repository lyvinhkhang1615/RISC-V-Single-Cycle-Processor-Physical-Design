`timescale 1ns / 1ps
/*
 * Copyright (c) 2023 Govardhan
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
module Instruction_Memory(
			  input 	clk,
			  input [31:0] 	A,
			  output [31:0] RD
			  );
   //-----------------------------------------------------------------------
   // GPDK045 macro version: instance of MEM1_256X32 (Cadence sync SRAM)
   // Pinout confirmed from timing/MEM1_256X32_slow.lib:
   //   CK      : clock, rising edge
   //   CE      : chip enable, ACTIVE-LOW  (CE=0 -> enabled)
   //   WE      : write enable, ACTIVE-HIGH (WE=1 -> write, WE=0 -> read)
   //   A[7:0]  : address, 256 words
   //   D[31:0] : data in
   //   Q[31:0] : data out
   //
   // NOTE: macro has no $readmemh-style preload. This module is a
   // read-only port into the macro (WE tied low). Program content must
   // be loaded via a write sequence at the testbench/boot level if you
   // need functional gate-level simulation; for synth/P&R/STA this
   // wrapper is sufficient as-is (macro is treated as a timing blackbox).
   //-----------------------------------------------------------------------

   MEM1_256X32 u_imem (
		       .CK (clk),
		       .CE (1'b0),      // always enabled
		       .WE (1'b0),      // always read
		       .A  (A[9:2]),    // word aligned, 8-bit address (256 words)
		       .D  (32'b0),
		       .Q  (RD)
		       );

endmodule

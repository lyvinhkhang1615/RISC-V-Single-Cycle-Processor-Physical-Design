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

module Data_Memory(
		   input wire 	      clk, WE,
		   input wire [31:0]  A, WD,
		   output wire [31:0] RD
		   );
   //-----------------------------------------------------------------------
   // GPDK045 macro version: instance of MEM1_256X32 (Cadence sync SRAM)
   // Same macro type as Instruction_Memory (2 separate physical
   // instances). WE polarity matches directly: WE=1 -> write, WE=0 -> read.
   //
   // NOTE: original testbench preload (RAM[0]=FACEFACE, RAM[63]=...) is
   // removed here since the macro cannot be preloaded like a behavioral
   // array. For gate-level functional simulation, drive WE/A/D from the
   // testbench to write these values in before applying reset.
   //-----------------------------------------------------------------------

   MEM1_256X32 u_dmem (
		       .CK (clk),
		       .CE (1'b0),      // always enabled
		       .WE (WE),        // active-high, matches WE directly
		       .A  (A[9:2]),    // word aligned, 8-bit address (256 words)
		       .D  (WD),
		       .Q  (RD)
		       );

endmodule

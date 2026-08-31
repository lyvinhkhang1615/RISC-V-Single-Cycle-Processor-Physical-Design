// Logical blackbox stub for MEM1_256X32 (GPDK045 Cadence sync SRAM macro).
// No functional body - RC/Genus binds actual timing from the .lib
// (dont_use/dont_touch = TRUE there), this stub only exists so
// elaboration doesn't error out on an "undefined module" for the
// macro instances inside Instruction_Memory.v / Data_Memory.v.
// Do NOT synthesize/optimize the inside of this module - it is emptied
// on purpose and is set as dont_touch in syn.tcl.

module MEM1_256X32 (
    input  wire        CK,
    input  wire        CE,
    input  wire        WE,
    input  wire [7:0]  A,
    input  wire [31:0] D,
    output wire [31:0] Q
);
endmodule

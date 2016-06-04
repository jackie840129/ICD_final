`timescale 1ns/10ps
module CLE ( clk, reset, rom_q, rom_a, sram_q, sram_a, sram_d, sram_wen, finish);
input         clk;
input         reset;
input  [7:0]  rom_q;
output [6:0]  rom_a;
input  [7:0]  sram_q;
output [9:0]  sram_a;
output [7:0]  sram_d;
output        sram_wen;
output        finish;

//parameter declaration
parameter IDLE      =2'd0;
parameter PROCESS   =2'd1;
parameter DONE      =2'd2;

//reg declaration

reg [6:0]   rom_a,    n_rom_a;
reg [9:0]   sram_a,   n_sram_a;
reg [7:0]   sram_d,   n_sram_d;
reg         sram_wen, n_sram_wen;
reg         finish,   n_finish;


endmodule

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
parameter READ      =2'd1;
parameter PROCCESS  =2'd2;
parameter DONE      =2'd3;

//reg declaration

reg [6:0]   rom_a,    n_rom_a;
reg [9:0]   sram_a,   n_sram_a;
reg [7:0]   sram_d,   n_sram_d;
reg [1:0]   state,    next_state;
reg         sram_wen, n_sram_wen;
reg         finish,   n_finish;

always@(posedge clk) begin
    if(reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always@(*) begin
    case(state)
        IDLE: begin
        end

        READ: begin
        end
        
        PROCCESS: begin
        end

        DONE: begin
        end
end

endmodule

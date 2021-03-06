`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    01:07:54 03/03/2016
// Design Name:
// Module Name:    PC
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module PC (
	input wire boardCLK,
	input wire dis_reset,
	input wire clk_reset,
	input wire cpu_reset,
	input wire mem_reset,
	input wire start,
	input wire enable
    );

wire CPU_Clock;
wire MEM_Clock;
wire CAC_Clock;

wire [7:0] i_addr;
wire [15:0] i_datain;

wire [15:0] d_mem2cpu;
wire [15:0] d_addr;
wire [15:0] d_cpu2mem;
wire d_we;
wire [15:0] cache_out;

CLK Clock (
	.RST(clk_reset), .B_CLK(boardCLK),
	.CPU_CLK(CPU_Clock), .MEM_CLK(MEM_Clock), .CAC_CLK(CAC_Clock)
	);

PCPU myCPU (
	.clock(CPU_Clock), .enable(enable), .start(start), .reset(~cpu_reset),
	.i_addr(i_addr), .i_datain(i_datain),
	.d_addr(d_addr), .d_datain(d_mem2cpu), .d_dataout(d_cpu2mem), .d_we(d_we),
	.cache_clock(CAC_Clock), .cache_reset(mem_reset)
	);

IM instructionMemory (
	.addr(i_addr), .iout(i_datain)
	);

DM dataMemory (
	.addr(d_addr), .dout(d_mem2cpu), .din(d_cpu2mem),
	.we(d_we), .clk(MEM_Clock), .reset(mem_reset)
	);

endmodule

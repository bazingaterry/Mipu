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
	input wire enable,
	// for board evaluation
	output wire [3:0] enableSignal,
	output wire [6:0] displayData,
	input wire add_in,
	input wire flag,
	input wire [1:0] select
    );

wire CPU_Clock;
wire MEM_Clock;
wire DEC_Clock;

wire [7:0] i_addr;
wire [15:0] i_datain;

wire [15:0] d_mem2cpu;
wire [7:0] d_addr;
wire [15:0] d_cpu2mem;
wire d_we;

wire [15:0] grData;
wire [15:0] memData;
wire displayEnable;
wire decoderReset;
wire [7:0] address;
wire [15:0] data;

Clock Clock (
	.RESET(clk_reset), .CLK_IN(boardCLK),
	.CPU_CLK(CPU_Clock), .MEM_CLK(MEM_Clock), .DEC_CLK(DEC_Clock)
	);

PCPU myCPU (
	.clock(CPU_Clock), .enable(enable), .start(start), .reset(~cpu_reset),
	.i_addr(i_addr), .i_datain(i_datain),
	.d_addr(d_addr), .d_datain(d_mem2cpu), .d_dataout(d_cpu2mem), .d_we(d_we),
	.grData(grData), .selectGr(address[2:0])
	);

IM instructionMemory (
	.addr(i_addr), .iout(i_datain)
	);
	
DM dataMemory (
	.addr(d_addr), .dout(d_mem2cpu), .din(d_cpu2mem),
	.we(d_we), .clk(MEM_Clock), .reset(mem_reset),
	.readAddr(address), .readData(memData)
	);

wire add_out;

KEY add(
	.BJ_CLK(DEC_Clock), .RESET(dis_reset),
	.BUTTON_IN(add_in), .BUTTON_OUT(add_out)
	);

DP display (
	.reset(dis_reset), .add(add_out), .select(select), .flag(flag),
	.memData(memData), .grData(grData), .address(address), .pc(i_addr),
	.data(data), .displayEnable(displayEnable)
	);

DCD decoder (
	.reset(dis_reset), .clk(DEC_Clock), .enable(displayEnable),
	.data(data), .enableSignal(enableSignal), .display(displayData)
	);
	
endmodule

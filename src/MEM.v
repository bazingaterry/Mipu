`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    14:39:13 12/30/2015
// Design Name:
// Module Name:    MEM
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

`include "define.v"

module MEM (
	input wire clock,
	input wire reset,
	input wire state,
	input wire [15:0] mem_ir,
	input wire [15:0] reg_C,
	input wire dw,
	input wire [15:0] smdr1,
	inout wire [15:0] d_datain,
	output reg [15:0] wb_ir,
	output reg [15:0] reg_C1,
	output wire [15:0] d_dataout,
	output wire [15:0] d_addr,
	output wire d_we
    );

assign d_addr = reg_C;
assign d_dataout = smdr1;
assign d_we = dw;

always @ (posedge clock or negedge reset) begin
    if(!reset) begin
		wb_ir     <= 16'b0000_0000_0000_0000;
		reg_C1    <= 16'b0000_0000_0000_0000;
    end
    else if (state == `exec) begin
		wb_ir <= mem_ir;

		if (mem_ir[15:11] == `LOAD)
			reg_C1 <= d_datain;
		else
			reg_C1 <= reg_C;
	end
end
endmodule

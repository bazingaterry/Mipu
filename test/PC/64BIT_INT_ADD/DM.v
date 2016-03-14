`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:00:36 03/03/2016 
// Design Name: 
// Module Name:    DM 
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

// SORT data

`include "define.v"

module DM (
	input wire [7:0] addr,
	output wire [15:0] dout,
	input wire [15:0] din,
	input wire we,
	input wire clk,
	input wire reset
    );

reg [15:0] mem [15:0];

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		mem[0] <= 16'hfffe;
		mem[1] <= 16'hfffe;
		mem[2] <= 16'hfffe;
		mem[3] <= 16'h0000;
		mem[4] <= 16'hffff;
		mem[5] <= 16'hffff;
		mem[6] <= 16'hffff;
		mem[7] <= 16'h0000;
	end
	else if (we) begin
		mem[addr] <= din;
	end
end

assign dout = mem[addr];

endmodule

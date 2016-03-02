`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:26 03/02/2016 
// Design Name: 
// Module Name:    JP 
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

module JP (
	input wire [15:0] mem_ir,
	input wire zf,
	input wire nf,
	input wire cf,
	output wire jump
    );

assign jump = (
				   ((mem_ir[15:11] == `BZ ) && (zf == 1'b1))
				|| ((mem_ir[15:11] == `BNZ) && (zf == 1'b0))
				|| ((mem_ir[15:11] == `BN ) && (nf == 1'b1))
				|| ((mem_ir[15:11] == `BNN) && (nf == 1'b0))
				|| ((mem_ir[15:11] == `BC)  && (cf == 1'b1))
				|| ((mem_ir[15:11] == `BNC) && (cf == 1'b0))
				||  (mem_ir[15:11] == `JMPR)
			  );
endmodule

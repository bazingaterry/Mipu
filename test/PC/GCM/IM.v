`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:00:36 03/03/2016 
// Design Name: 
// Module Name:    IM 
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

// SORT instruction

`include "define.v"

module IM (
	input wire [7:0] addr,
	output reg [15:0] iout
    );

always @ (*) begin
	case (addr[7:0])
		00: iout = {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
		01: iout = {`LOAD, `gr2, 1'b0, `gr0, 4'b0010};
		02: iout = {`ADD, `gr3, 1'b0, `gr0, 1'b0, `gr1};//(1)
		03: iout = {`SUB, `gr1, 1'b0, `gr1, 1'b0, `gr2};
		04: iout = {`BZ, `gr0, 8'b0000_1001}; //jump to (2)
		05: iout = {`BNN, `gr0,  8'b0000_0010}; //jump to (1)
		06: iout = {`ADD, `gr1, 1'b0, `gr0, 1'b0, `gr2};
		07: iout = {`ADD, `gr2, 1'b0, `gr0, 1'b0, `gr3};
		08: iout = {`JUMP, 11'b000_0000_0010};//jump to (1)
		09: iout = {`STORE, `gr2, 1'b0, `gr0, 4'b0011}; //(2)
		10: iout = {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
		11: iout = {`LOAD, `gr2, 1'b0, `gr0, 4'b0010};
		12: iout = {`ADDI, `gr4, 8'h1}; //(3)
		13: iout = {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr3};
		14: iout = {`BZ, `gr0, 8'b0001_0000}; //jump to (4)
		15: iout = {`JUMP, 11'b000_0000_1100}; //jump to (3)
		16: iout = {`SUBI, `gr4, 8'h1}; //(4)
		17: iout = {`BN, `gr0, 8'b0001_0100}; //jump to (5)
		18: iout = {`ADD, `gr5, 1'b0, `gr5, 1'b0, `gr1};
		19: iout = {`JUMP, 11'b000_0001_0000}; //jump to (4)
		20: iout = {`STORE, `gr5, 1'b0, `gr0, 4'b0100}; //(5)
		21: iout = {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};//最大公因数
		22: iout = {`LOAD, `gr2, 1'b0, `gr0, 4'b0100};//最小公倍数
		23: iout = {`HALT, 11'b000_0000_0000};
		default : iout = {`HALT, 11'd0};
	endcase
end
endmodule

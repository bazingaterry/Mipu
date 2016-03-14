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
		00 : iout = {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};//	gr1 = 00ab
		01 : iout = {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};//	gr2 = 3c00
		02 : iout = {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};//	gr3 = 3cab
		03 : iout = {`ADD, `gr4, 1'b0, `gr3, 1'b0, `gr2};//	gr4 = 78ab
		04 : iout = {`SUB, `gr5, 1'b0, `gr4, 1'b0, `gr2};//	gr5 = 3cab
		05 : iout = {`CMP, 3'b000, 1'b0, `gr5, 1'b0, `gr5};//zf = 1
		06 : iout = {`BZ, `gr0, 8'b0000_1011};			// JUMP to 2'h0b
		07 : iout = {`ADD, `gr6, 1'b0, `gr4, 1'b0, `gr3};
		08 : iout = {`ADD, `gr7, 1'b0, `gr5, 1'b0, `gr6};
		09 : iout = {`SUB, `gr1, 1'b0, `gr7, 1'b0, `gr6};
		10 : iout = {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
		11 : iout = {`STORE, `gr4, 1'b0, `gr0, 4'b0011};//	mem[3] = 78ab
		12 : iout = {`STORE, `gr5, 1'b0, `gr0, 4'b0100};//	mem[4] = 3cab
		13 : iout = {`STORE, `gr6, 1'b0, `gr0, 4'b0101};//	mem[5] = 0000
		14 : iout = {`STORE, `gr7, 1'b0, `gr0, 4'b0110};//	mem[6] = 0000
		15 : iout = {`STORE, `gr1, 1'b0, `gr0, 4'b0111};//	mem[7] = 00ab
		16 : iout = {`HALT, 11'b000_0000_0000};
		default : iout = {`HALT, 11'd0};
	endcase
end
endmodule

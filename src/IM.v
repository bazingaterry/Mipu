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

`include "define.v"

module IM (
	input wire [7:0] addr,
	output reg [15:0] iout
    );

always @ (*) begin
	case (addr[7:0])
		00 : iout = {`ADDI, `gr1, 4'b0000,  4'b1001};
		01 : iout = {`ADDI, `gr2, 4'b0000,  4'b1001};
		02 : iout = {`JUMP, 11'b000_0000_0101};//jump to start
		03 : iout = {`SUBI, `gr1, 4'd0, 4'd1};//new_round
		04 : iout = {`BZ, `gr7, 4'b0001, 4'b0010};//jump to end
		05 : iout = {`LOAD, `gr3, 1'b0, `gr0, 4'd0};//start
		06 : iout = {`LOAD, `gr4, 1'b0, `gr0, 4'd1};
		07 : iout = {`CMP, 3'd0, 1'b0, `gr3, 1'b0, `gr4};
		08 : iout = {`BN, `gr7, 4'h0, 4'b1011};//jump to NO_op
		09 : iout = {`STORE, `gr3, 1'b0, `gr0, 4'd1};
		10 : iout = {`STORE, `gr4, 1'b0, `gr0, 4'd0};
		11 : iout = {`ADDI, `gr0, 4'b0000, 4'b0001};//NO_OP
		12 : iout = {`CMP, 3'd0, 1'b0, `gr0, 1'b0, `gr2};
		13 : iout = {`BN, `gr7, 4'b0001, 4'b0001};//jump to continue 
		14 : iout = {`SUBI, `gr2, 4'd0, 4'd1};
		15 : iout = {`SUB, `gr0, 1'b0,`gr0, 1'b0,`gr0};
		16 : iout = {`JUMP, 11'b000_0000_0011};//jump to new round
		17 : iout = {`JUMP, 11'b000_0000_0101};//jump to start,continue
		18 : iout = {`HALT, 11'd0};
		default : iout = {`HALT, 11'd0};
	endcase
end
endmodule

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
		00: iout = 16'h4c04 ;
		01: iout = 16'h1100 ;
		02: iout = 16'h1204 ;
		03: iout = 16'h4312 ;
		04: iout = 16'hfd06 ;//bnc to 6
		05: iout = 16'h4e01 ;
		06: iout = 16'h4337 ;	
		07: iout = 16'hfd0b ;//bnc to 11
		08: iout = 16'h5e00 ;
		09: iout = 16'hdd0b ;//bnz to 11
		10: iout = 16'h4e01 ;   
		11: iout = 16'h5777 ;	
		12: iout = 16'h4776 ;  
		13: iout = 16'h5666 ;		
		14: iout = 16'h1b08 ;
		15: iout = 16'h4801 ;		
		16: iout = 16'h6004 ;
		17: iout = 16'he501 ;//bn to 1
		18: iout = 16'h0800 ;
		default : iout = {`HALT, 11'd0};
	endcase
end
endmodule

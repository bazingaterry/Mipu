`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:26 12/30/2015 
// Design Name: 
// Module Name:    IF 
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

module IF (
	input wire clock,
	input wire reset,
	input wire state,
	input wire [15:0] reg_C,
	input wire zf,
	input wire nf,
	input wire cf,
	input wire [15:0] mem_ir,
	input wire [15:0] i_datain,
	input wire [15:0] id_iri,
	output reg [15:0] id_iro,
	output wire [7:0] i_addr
    );

reg [7:0] pc;

assign i_addr = pc;

always @ (posedge clock or negedge reset) begin
	if (!reset) begin
		id_iro <= 16'b0000_0000_0000_0000;
		pc <= 8'b0000_0000;
	end
	else if (state == `exec) begin
		id_iro <= i_datain;

		if (id_iri[15:11] == `JUMP)
			pc <= id_iri[7:0];
		else if (
			   ((mem_ir[15:11] == `BZ ) && (zf == 1'b1))
			|| ((mem_ir[15:11] == `BNZ) && (zf == 1'b0))
			|| ((mem_ir[15:11] == `BN ) && (nf == 1'b1))
			|| ((mem_ir[15:11] == `BNN) && (nf == 1'b0))
			|| ((mem_ir[15:11] == `BC)  && (cf == 1'b1))
			|| ((mem_ir[15:11] == `BNC) && (cf == 1'b0))
			||  (mem_ir[15:11] == `JMPR)
		   )
			pc <= reg_C[7:0];
		else
			pc <= pc + 1'b1;
	end
end
endmodule

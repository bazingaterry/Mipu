`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:45 12/30/2015 
// Design Name: 
// Module Name:    ID 
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

module ID (
	input wire clock,
	input wire reset,
	inout wire state,
	input wire [15:0] id_ir,
	input wire [15:0] gr0,
	input wire [15:0] gr1,
	input wire [15:0] gr2,
	input wire [15:0] gr3,
	input wire [15:0] gr4,
	input wire [15:0] gr5,
	input wire [15:0] gr6,
	input wire [15:0] gr7,
	output reg [15:0] ex_ir,
	output reg [15:0] reg_A,
	output reg [15:0] reg_B,
	output reg [15:0] smdr
    );

wire [15:0] gr [7:0];

assign gr[0] = gr0;
assign gr[1] = gr1;
assign gr[2] = gr2;
assign gr[3] = gr3;
assign gr[4] = gr4;
assign gr[5] = gr5;
assign gr[6] = gr6;
assign gr[7] = gr7;

always@(posedge clock or negedge reset) begin
	if(!reset) begin
		ex_ir <= 16'b0000_0000_0000_0000;
		reg_A <= 16'b0000_0000_0000_0000;
		reg_B <= 16'b0000_0000_0000_0000;
		smdr  <= 16'b0000_0000_0000_0000;
	end
	else if (state == `exec) begin
		ex_ir <= id_ir;

		//	write reg_A
		if (
			   (id_ir[15:11] == `BZ) || (id_ir[15:11] == `BNZ)
			|| (id_ir[15:11] == `BN) || (id_ir[15:11] == `BNN)
			|| (id_ir[15:11] == `BC) || (id_ir[15:11] == `BNC)
			|| (id_ir[15:11] == `JMPR) || (id_ir[15:11] == `ADDI)
			|| (id_ir[15:11] == `SUBI) || (id_ir[15:11] == `LDIH)
		   )
		   	//	reg_A <= gr1
			reg_A <= gr[id_ir[10:8]];
		else if (
				 	(id_ir[15:11] == `LOAD)|| (id_ir[15:11] == `STORE)
				 || (id_ir[15:11] == `ADD) || (id_ir[15:11] == `ADDC)
				 || (id_ir[15:11] == `SUB) || (id_ir[15:11] == `SUBC)
				 || (id_ir[15:11] == `CMP) || (id_ir[15:11] == `AND)
				 || (id_ir[15:11] == `OR)  || (id_ir[15:11] == `XOR)
				 || (id_ir[15:11] == `SLL) || (id_ir[15:11] == `SRL)
				 || (id_ir[15:11] == `SLA) || (id_ir[15:11] == `SRA)
				)
			//	reg_A <= gr2
			reg_A <= gr[id_ir[6:4]];

		//	write reg_B
		if (
				(id_ir[15:11] == `LOAD) || (id_ir[15:11] == `SLL)
			 || (id_ir[15:11] == `SRL)  || (id_ir[15:11] == `SLA)
			 || (id_ir[15:11] == `SRA)  || (id_ir[15:11] == `STORE)
		   )
			//	reg_B <= val3
			reg_B <= {12'b0000_0000_0000, id_ir[3:0]};
		else if (id_ir[15:11] == `LDIH)
			//	reg_B <= {val2, val3, 8'b0000_0000}
			reg_B <= {id_ir[7:0], 8'b0000_0000};
		else if (
				   (id_ir[15:11] == `BZ) || (id_ir[15:11] == `BNZ)
				|| (id_ir[15:11] == `BN) || (id_ir[15:11] == `BNN)
				|| (id_ir[15:11] == `BC) || (id_ir[15:11] == `BNC)
				|| (id_ir[15:11] == `JUMP) || (id_ir[15:11] == `JMPR)
				|| (id_ir[15:11] == `ADDI) || (id_ir[15:11] == `SUBI)
				)
			//	reg_B <= {val2, val3}
			reg_B <= {8'b0000_0000, id_ir[7:0]};
		else if (
					(id_ir[15:11] == `ADD) || (id_ir[15:11] == `ADDC)
				 || (id_ir[15:11] == `SUB) || (id_ir[15:11] == `SUBC)
				 || (id_ir[15:11] == `CMP) || (id_ir[15:11] == `AND)
				 || (id_ir[15:11] == `OR)  || (id_ir[15:11] == `XOR)
				)
			//	reg_B <= gr3
			reg_B <= {12'b0000_0000_0000, gr[id_ir[2:0]]};

		//	write smdr
		if (id_ir[15:11] == `STORE)
			smdr <= gr[id_ir[10:8]];
	end
end
endmodule

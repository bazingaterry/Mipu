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
	input wire jump,
	input wire [15:0] mem_ir,
	input wire [15:0] i_datain,
	output reg [15:0] id_ir,
	output wire [7:0] i_addr
    );

reg [7:0] pc;

assign i_addr = pc;

always @ (posedge clock or negedge reset) begin
	if (!reset) begin
		id_ir <= 16'b0000_0000_0000_0000;
		pc <= 8'b0000_0000;
	end
	else if (state == `exec) begin
		if (jump) begin
			id_ir <= 16'b0000_0000_0000_0000;//i_datain;
			pc <= reg_C[7:0];
		end
		else if (id_ir[15:11] == `JUMP) begin
			id_ir <= 16'b0000_0000_0000_0000;//i_datain;
			pc <= id_ir[7:0];
		end
		else if (//	LOAD hazard
			     (id_ir[15:11] == `LOAD) &&
			     	(   (( (i_datain[15:11] == `SLL) || (i_datain[15:11] == `SRA) 
			     		|| (i_datain[15:11] == `SRL) || (i_datain[15:11] == `SLA)
	            		) && (id_ir[10:8] == i_datain[6:4]))
			     	|| 
	                    ((
	                    	(i_datain[15:11] == `ADD) || (i_datain[15:11] == `ADDC)
	                    ||	(i_datain[15:11] == `SUB) || (i_datain[15:11] == `SUBC)
	                    ||	(i_datain[15:11] == `CMP) || (i_datain[15:11] == `AND)
	                    ||	(i_datain[15:11] == `OR)  || (i_datain[15:11] == `XOR)
	                    ) && ((id_ir[10:8] == i_datain[6:4]) || (id_ir[10:8] == i_datain[2:0])))
	                ||
	                	((i_datain[15:11] == `ADDI) || (i_datain[15:11] == `SUBI)) 
	                	&& (id_ir[10:8] == i_datain[10:8])
	                ) 
			    ) begin
			id_ir <= 16'b0000_0000_0000_0000;
			pc <= pc;
		end// no hazard
		else begin 
			pc <= pc + 1'b1;
			id_ir <= i_datain;
		end 
	end
end
endmodule

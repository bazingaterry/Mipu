`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:55:22 12/31/2015 
// Design Name: 
// Module Name:    ALU 
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

module ALU (
	input wire [15:0] ex_ir,
	input wire [15:0] reg_A,
	input wire [15:0] reg_B,
	input wire cfin,
	input wire [15:0] ALUi,
	output reg cfout,
	output reg [15:0] ALUo
    );

always @ (*)      
    case(ex_ir[15:11])
        `LOAD   : {cfout, ALUo} <= reg_A + reg_B;
        `STORE  : {cfout, ALUo} <= reg_A + reg_B;
        `LDIH   : {cfout, ALUo} <= reg_A + reg_B; 
        `ADD    : {cfout, ALUo} <= reg_A + reg_B;
        `ADDI   : {cfout, ALUo} <= reg_A + reg_B;
        `ADDC   : {cfout, ALUo} <= reg_A + reg_B + cfin;
        `SUB    : {cfout, ALUo} <= reg_A - reg_B;
        `SUBI   : {cfout, ALUo} <= reg_A - reg_B;
        `SUBC   : {cfout, ALUo} <= reg_A - reg_B - cfin;
        `CMP    : {cfout, ALUo} <= reg_A - reg_B;
        `AND    : {cfout, ALUo} <= reg_A & reg_B;
        `OR     : {cfout, ALUo} <= reg_A | reg_B;
        `XOR    : {cfout, ALUo} <= reg_A ^ reg_B;
        `SLL    : {cfout, ALUo} <= reg_A << reg_B[3:0];
        `SRL    : {cfout, ALUo} <= reg_A >> reg_B[3:0];
        `SLA    : {cfout, ALUo} <= $signed(reg_A) <<< reg_B[3:0];
        `SRA    : {cfout, ALUo} <= $signed(reg_A) >>> reg_B[3:0];
        `JUMP   : {cfout, ALUo} <= reg_B;
        `JMPR   : {cfout, ALUo} <= reg_A + reg_B;
        `BZ     : {cfout, ALUo} <= reg_A + reg_B;
        `BNZ    : {cfout, ALUo} <= reg_A + reg_B;
        `BN     : {cfout, ALUo} <= reg_A + reg_B;
        `BNN    : {cfout, ALUo} <= reg_A + reg_B;
        `BC     : {cfout, ALUo} <= reg_A + reg_B;
        `BNC    : {cfout, ALUo} <= reg_A + reg_B;
        default : {cfout, ALUo} <= {cfin, ALUi};
     endcase
endmodule

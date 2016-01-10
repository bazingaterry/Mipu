`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:13 12/30/2015 
// Design Name: 
// Module Name:    MEM 
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

module MEM (
	input wire clock,
	input wire reset,
	input wire state,
	input wire [15:0] mem_ir,
	input wire [15:0] reg_C,
	input wire dw,
	input wire [15:0] smdr1,
	inout wire [15:0] d_datain,
	output reg [15:0] wb_ir,
	output reg [15:0] reg_C1,
	output reg [15:0] d_dataout,
	output reg [7:0] d_addr,
	output reg d_we
    );

always @ (posedge clock or negedge reset) begin
    if(!reset) begin
		wb_ir     <= 16'b0000_0000_0000_0000;
		reg_C1    <= 16'b0000_0000_0000_0000;
		d_we      <= 0;
		d_addr    <= 8'b0;
		d_dataout <= 16'b0;
    end
    else if (state == `exec) begin
		wb_ir <= mem_ir; 
		if (mem_ir[15:11] == `LOAD) begin
			d_we   <= dw;
			reg_C1 <= d_datain;
		end
		else if (mem_ir[15:11] == `STORE) begin
			d_we      <= dw;
			d_addr    <= reg_C[7:0];
			d_dataout <= smdr1;
		end
		else
			reg_C1 <= reg_C;
	end
end

endmodule

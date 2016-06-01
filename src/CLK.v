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

module CLK (
    input wire RST,
    input wire B_CLK,
    output reg CPU_CLK,
    output reg MEM_CLK
    );

reg [1:0] CLK_DIV;

always @ (posedge B_CLK or posedge RST) begin
    if (RST) begin
        CLK_DIV <= 0;
    end
    else begin
        CLK_DIV <= CLK_DIV + 1;
    end
end

always @ (*) begin
    MEM_CLK <= B_CLK;
    CPU_CLK <= CLK_DIV[1];
end

endmodule

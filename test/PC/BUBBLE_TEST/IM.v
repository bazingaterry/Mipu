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
        0:  iout =  {`LOAD, `gr3, 1'b0, `gr0, 4'b0000};
        1:  iout =  {`SUBI, `gr3, 4'd0, 4'd2};
        2:  iout =  {`ADD, `gr1, 1'b0, `gr0, 1'b0, `gr0};
        3:  iout =  {`ADD, `gr2, 1'b0, `gr3, 1'b0, `gr0}; // loop1
        4:  iout =  {`LOAD, `gr4, 1'b0, `gr2, 4'd1}; // loop2
        5:  iout =  {`LOAD, `gr5, 1'b0, `gr2, 4'd2};
        6:  iout =  {`CMP, 3'd0, 1'b0, `gr5, 1'b0, `gr4};
        7:  iout =  {`BN, `gr0, 4'b0000, 4'b1010};
        8:  iout =  {`STORE, `gr4, 1'b0, `gr2, 4'd2};
        9:  iout =  {`STORE, `gr5, 1'b0, `gr2, 4'd1};
        10: iout =  {`SUBI, `gr2, 4'd0, 4'd1};
        11: iout =  {`CMP, 3'd0, 1'b0, `gr2, 1'b0, `gr1};
        12: iout =  {`BNN, `gr0, 4'h0, 4'b0100};
        13: iout =  {`ADDI, `gr1, 4'd0, 4'd1};
        14: iout =  {`CMP, 3'd0, 1'b0, `gr3, 1'b0, `gr1};
        15: iout =  {`BNN, `gr0, 4'h0, 4'b0011};
        16: iout =  {`HALT, 11'd0};
        default : iout = {`HALT, 11'd0};
    endcase
end
endmodule

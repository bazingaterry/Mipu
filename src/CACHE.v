`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:36:03 05/31/2016
// Design Name:
// Module Name:    CACHE
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

module CACHE (
    input wire clock,
    input wire reset,
    input wire [15:0] instr,
    input wire [15:0] d_addr,
    input wire [15:0] d_datain,
    input wire [15:0] d_dataout,
    output reg [15:0] data_out,
    output reg hit
    );


reg [31:0] cache [127:0];

wire [6:0] index;
reg way;

// CACHE:
// 15 - 0 : data
// 23 - 16: tag
// 30 - 24: counter
// 31 - 31: use bit

// MEM_ADDR:
// 15-7: tag
// 6-0: index

assign index = d_addr[6:0];

always @ (*) begin
    if (instr[15:11] == `LOAD || instr[15:11] == `STORE) begin
        if (cache[index][23:16] == d_addr[15:7] && cache[index][31] == 1) begin
            hit <= 1;
        end else begin
            hit <= 0;
        end
    end else
        hit <= 0;
end

always @ (posedge clock or posedge reset) begin
    if (reset) begin
        cache[0] <= 0;
        cache[1] <= 0;
        cache[2] <= 0;
        cache[3] <= 0;
        cache[4] <= 0;
        cache[5] <= 0;
        cache[6] <= 0;
        cache[7] <= 0;
        cache[8] <= 0;
        cache[9] <= 0;
        cache[10] <= 0;
        cache[11] <= 0;
        cache[12] <= 0;
        cache[13] <= 0;
        cache[14] <= 0;
        cache[15] <= 0;
        cache[16] <= 0;
        cache[17] <= 0;
        cache[18] <= 0;
        cache[19] <= 0;
        cache[20] <= 0;
        cache[21] <= 0;
        cache[22] <= 0;
        cache[23] <= 0;
        cache[24] <= 0;
        cache[25] <= 0;
        cache[26] <= 0;
        cache[27] <= 0;
        cache[28] <= 0;
        cache[29] <= 0;
        cache[30] <= 0;
        cache[31] <= 0;
        cache[32] <= 0;
        cache[33] <= 0;
        cache[34] <= 0;
        cache[35] <= 0;
        cache[36] <= 0;
        cache[37] <= 0;
        cache[38] <= 0;
        cache[39] <= 0;
        cache[40] <= 0;
        cache[41] <= 0;
        cache[42] <= 0;
        cache[43] <= 0;
        cache[44] <= 0;
        cache[45] <= 0;
        cache[46] <= 0;
        cache[47] <= 0;
        cache[48] <= 0;
        cache[49] <= 0;
        cache[50] <= 0;
        cache[51] <= 0;
        cache[52] <= 0;
        cache[53] <= 0;
        cache[54] <= 0;
        cache[55] <= 0;
        cache[56] <= 0;
        cache[57] <= 0;
        cache[58] <= 0;
        cache[59] <= 0;
        cache[60] <= 0;
        cache[61] <= 0;
        cache[62] <= 0;
        cache[63] <= 0;
        cache[64] <= 0;
        cache[65] <= 0;
        cache[66] <= 0;
        cache[67] <= 0;
        cache[68] <= 0;
        cache[69] <= 0;
        cache[70] <= 0;
        cache[71] <= 0;
        cache[72] <= 0;
        cache[73] <= 0;
        cache[74] <= 0;
        cache[75] <= 0;
        cache[76] <= 0;
        cache[77] <= 0;
        cache[78] <= 0;
        cache[79] <= 0;
        cache[80] <= 0;
        cache[81] <= 0;
        cache[82] <= 0;
        cache[83] <= 0;
        cache[84] <= 0;
        cache[85] <= 0;
        cache[86] <= 0;
        cache[87] <= 0;
        cache[88] <= 0;
        cache[89] <= 0;
        cache[90] <= 0;
        cache[91] <= 0;
        cache[92] <= 0;
        cache[93] <= 0;
        cache[94] <= 0;
        cache[95] <= 0;
        cache[96] <= 0;
        cache[97] <= 0;
        cache[98] <= 0;
        cache[99] <= 0;
        cache[100] <= 0;
        cache[101] <= 0;
        cache[102] <= 0;
        cache[103] <= 0;
        cache[104] <= 0;
        cache[105] <= 0;
        cache[106] <= 0;
        cache[107] <= 0;
        cache[108] <= 0;
        cache[109] <= 0;
        cache[110] <= 0;
        cache[111] <= 0;
        cache[112] <= 0;
        cache[113] <= 0;
        cache[114] <= 0;
        cache[115] <= 0;
        cache[116] <= 0;
        cache[117] <= 0;
        cache[118] <= 0;
        cache[119] <= 0;
        cache[120] <= 0;
        cache[121] <= 0;
        cache[122] <= 0;
        cache[123] <= 0;
        cache[124] <= 0;
        cache[125] <= 0;
        cache[126] <= 0;
        cache[127] <= 0;
    end
    else if (instr[15:11] == `LOAD) begin
        if (hit) begin
            data_out <= cache[index][15:0];
        end else begin
            cache[index][31] <= 1;
            cache[index][15:0] <= d_datain;
            data_out <= d_datain;
        end
    end else if (instr[15:11] == `STORE) begin
        cache[index][31] <= 1;
        cache[index][23:16] <= d_addr[15:7];
        cache[index][15:0] <= d_dataout;
    end
end

endmodule

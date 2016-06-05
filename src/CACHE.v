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
	input wire state,
    input wire [15:0] instr,
    input wire [15:0] d_addr,
    input wire [15:0] d_datain,
    input wire [15:0] d_dataout,
    output reg [15:0] data_out
    );

reg [31:0] hit_cnt;
reg [31:0] miss_cnt;

reg [31:0] cache0 [127:0];
reg [31:0] cache1 [127:0];

wire [6:0] index;
reg hit;
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
        if (cache0[index][23:16] == d_addr[15:7] && cache0[index][31] == 1) begin
            hit <= 1;
            way <= 0;
        end else if (cache1[index][23:16] == d_addr[15:7] && cache1[index][31] == 1) begin
            hit <= 1;
            way <= 1;
        end else begin
            hit <= 0;
            way <= 0;
        end
    end else begin
        hit <= 0;
        way <= 0;
    end
end

reg [6:0] i;

always @ (posedge clock or posedge reset) begin
    if (reset) begin
        hit_cnt <= 0;
        miss_cnt <= 0;
        cache0[1] <= 0;
        cache1[1] <= 0;
        cache0[2] <= 0;
        cache1[2] <= 0;
        cache0[3] <= 0;
        cache1[3] <= 0;
        cache0[4] <= 0;
        cache1[4] <= 0;
        cache0[5] <= 0;
        cache1[5] <= 0;
        cache0[6] <= 0;
        cache1[6] <= 0;
        cache0[7] <= 0;
        cache1[7] <= 0;
        cache0[8] <= 0;
        cache1[8] <= 0;
        cache0[9] <= 0;
        cache1[9] <= 0;
        cache0[10] <= 0;
        cache1[10] <= 0;
        cache0[11] <= 0;
        cache1[11] <= 0;
        cache0[12] <= 0;
        cache1[12] <= 0;
        cache0[13] <= 0;
        cache1[13] <= 0;
        cache0[14] <= 0;
        cache1[14] <= 0;
        cache0[15] <= 0;
        cache1[15] <= 0;
        cache0[16] <= 0;
        cache1[16] <= 0;
        cache0[17] <= 0;
        cache1[17] <= 0;
        cache0[18] <= 0;
        cache1[18] <= 0;
        cache0[19] <= 0;
        cache1[19] <= 0;
        cache0[20] <= 0;
        cache1[20] <= 0;
        cache0[21] <= 0;
        cache1[21] <= 0;
        cache0[22] <= 0;
        cache1[22] <= 0;
        cache0[23] <= 0;
        cache1[23] <= 0;
        cache0[24] <= 0;
        cache1[24] <= 0;
        cache0[25] <= 0;
        cache1[25] <= 0;
        cache0[26] <= 0;
        cache1[26] <= 0;
        cache0[27] <= 0;
        cache1[27] <= 0;
        cache0[28] <= 0;
        cache1[28] <= 0;
        cache0[29] <= 0;
        cache1[29] <= 0;
        cache0[30] <= 0;
        cache1[30] <= 0;
        cache0[31] <= 0;
        cache1[31] <= 0;
        cache0[32] <= 0;
        cache1[32] <= 0;
        cache0[33] <= 0;
        cache1[33] <= 0;
        cache0[34] <= 0;
        cache1[34] <= 0;
        cache0[35] <= 0;
        cache1[35] <= 0;
        cache0[36] <= 0;
        cache1[36] <= 0;
        cache0[37] <= 0;
        cache1[37] <= 0;
        cache0[38] <= 0;
        cache1[38] <= 0;
        cache0[39] <= 0;
        cache1[39] <= 0;
        cache0[40] <= 0;
        cache1[40] <= 0;
        cache0[41] <= 0;
        cache1[41] <= 0;
        cache0[42] <= 0;
        cache1[42] <= 0;
        cache0[43] <= 0;
        cache1[43] <= 0;
        cache0[44] <= 0;
        cache1[44] <= 0;
        cache0[45] <= 0;
        cache1[45] <= 0;
        cache0[46] <= 0;
        cache1[46] <= 0;
        cache0[47] <= 0;
        cache1[47] <= 0;
        cache0[48] <= 0;
        cache1[48] <= 0;
        cache0[49] <= 0;
        cache1[49] <= 0;
        cache0[50] <= 0;
        cache1[50] <= 0;
        cache0[51] <= 0;
        cache1[51] <= 0;
        cache0[52] <= 0;
        cache1[52] <= 0;
        cache0[53] <= 0;
        cache1[53] <= 0;
        cache0[54] <= 0;
        cache1[54] <= 0;
        cache0[55] <= 0;
        cache1[55] <= 0;
        cache0[56] <= 0;
        cache1[56] <= 0;
        cache0[57] <= 0;
        cache1[57] <= 0;
        cache0[58] <= 0;
        cache1[58] <= 0;
        cache0[59] <= 0;
        cache1[59] <= 0;
        cache0[60] <= 0;
        cache1[60] <= 0;
        cache0[61] <= 0;
        cache1[61] <= 0;
        cache0[62] <= 0;
        cache1[62] <= 0;
        cache0[63] <= 0;
        cache1[63] <= 0;
        cache0[64] <= 0;
        cache1[64] <= 0;
        cache0[65] <= 0;
        cache1[65] <= 0;
        cache0[66] <= 0;
        cache1[66] <= 0;
        cache0[67] <= 0;
        cache1[67] <= 0;
        cache0[68] <= 0;
        cache1[68] <= 0;
        cache0[69] <= 0;
        cache1[69] <= 0;
        cache0[70] <= 0;
        cache1[70] <= 0;
        cache0[71] <= 0;
        cache1[71] <= 0;
        cache0[72] <= 0;
        cache1[72] <= 0;
        cache0[73] <= 0;
        cache1[73] <= 0;
        cache0[74] <= 0;
        cache1[74] <= 0;
        cache0[75] <= 0;
        cache1[75] <= 0;
        cache0[76] <= 0;
        cache1[76] <= 0;
        cache0[77] <= 0;
        cache1[77] <= 0;
        cache0[78] <= 0;
        cache1[78] <= 0;
        cache0[79] <= 0;
        cache1[79] <= 0;
        cache0[80] <= 0;
        cache1[80] <= 0;
        cache0[81] <= 0;
        cache1[81] <= 0;
        cache0[82] <= 0;
        cache1[82] <= 0;
        cache0[83] <= 0;
        cache1[83] <= 0;
        cache0[84] <= 0;
        cache1[84] <= 0;
        cache0[85] <= 0;
        cache1[85] <= 0;
        cache0[86] <= 0;
        cache1[86] <= 0;
        cache0[87] <= 0;
        cache1[87] <= 0;
        cache0[88] <= 0;
        cache1[88] <= 0;
        cache0[89] <= 0;
        cache1[89] <= 0;
        cache0[90] <= 0;
        cache1[90] <= 0;
        cache0[91] <= 0;
        cache1[91] <= 0;
        cache0[92] <= 0;
        cache1[92] <= 0;
        cache0[93] <= 0;
        cache1[93] <= 0;
        cache0[94] <= 0;
        cache1[94] <= 0;
        cache0[95] <= 0;
        cache1[95] <= 0;
        cache0[96] <= 0;
        cache1[96] <= 0;
        cache0[97] <= 0;
        cache1[97] <= 0;
        cache0[98] <= 0;
        cache1[98] <= 0;
        cache0[99] <= 0;
        cache1[99] <= 0;
        cache0[100] <= 0;
        cache1[100] <= 0;
        cache0[101] <= 0;
        cache1[101] <= 0;
        cache0[102] <= 0;
        cache1[102] <= 0;
        cache0[103] <= 0;
        cache1[103] <= 0;
        cache0[104] <= 0;
        cache1[104] <= 0;
        cache0[105] <= 0;
        cache1[105] <= 0;
        cache0[106] <= 0;
        cache1[106] <= 0;
        cache0[107] <= 0;
        cache1[107] <= 0;
        cache0[108] <= 0;
        cache1[108] <= 0;
        cache0[109] <= 0;
        cache1[109] <= 0;
        cache0[110] <= 0;
        cache1[110] <= 0;
        cache0[111] <= 0;
        cache1[111] <= 0;
        cache0[112] <= 0;
        cache1[112] <= 0;
        cache0[113] <= 0;
        cache1[113] <= 0;
        cache0[114] <= 0;
        cache1[114] <= 0;
        cache0[115] <= 0;
        cache1[115] <= 0;
        cache0[116] <= 0;
        cache1[116] <= 0;
        cache0[117] <= 0;
        cache1[117] <= 0;
        cache0[118] <= 0;
        cache1[118] <= 0;
        cache0[119] <= 0;
        cache1[119] <= 0;
        cache0[120] <= 0;
        cache1[120] <= 0;
        cache0[121] <= 0;
        cache1[121] <= 0;
        cache0[122] <= 0;
        cache1[122] <= 0;
        cache0[123] <= 0;
        cache1[123] <= 0;
        cache0[124] <= 0;
        cache1[124] <= 0;
        cache0[125] <= 0;
        cache1[125] <= 0;
        cache0[126] <= 0;
        cache1[126] <= 0;
        cache0[127] <= 0;
        cache1[127] <= 0;
    end
    else if (state == `exec) begin
        if (instr[15:11] == `LOAD) begin
            if (hit) begin
                hit_cnt <= hit_cnt + 1;
                if (way == 0) begin
                    data_out <= cache0[index][15:0];    // load from cache
                    cache0[index][30:24] <= 0;          // clear cnt
                    cache1[index][30:24] <= cache1[index][30:24] + 1;   // add the other way's cnt
                end else begin
                    data_out <= cache1[index][15:0];
                    cache1[index][30:24] <= 0;
                    cache0[index][30:24] <= cache0[index][30:24] + 1;
                end
            end else begin
                miss_cnt <= miss_cnt + 1;
                hit_cnt <= hit_cnt - 1;
                if (cache0[index][31] == 0) begin
                    cache0[index][31] <= 1;     // set use bit
                    cache0[index][30:24] <= 0;  //  clear cnt
                    cache0[index][23:16] <= d_addr[15:7];   // update tag
                    cache0[index][15:0] <= d_datain;    // load to cache
                    data_out <= d_datain;       //  load from mem
                end else if (cache1[index][31] == 0) begin
                    cache1[index][31] <= 1;
                    cache1[index][30:24] <= 0;
                    cache1[index][23:16] <= d_addr[15:7];
                    cache1[index][15:0] <= d_datain;
                    data_out <= d_datain;
                end else if (cache0[index][30:24] > cache1[index][30:24]) begin
                    cache0[index][31] <= 1;
                    cache0[index][30:24] <= 0;
                    cache0[index][23:16] <= d_addr[15:7];
                    cache0[index][15:0] <= d_datain;
                    data_out <= d_datain;
                end else begin
                    cache1[index][31] <= 1;
                    cache1[index][30:24] <= 0;
                    cache1[index][23:16] <= d_addr[15:7];
                    cache1[index][15:0] <= d_datain;
                    data_out <= d_datain;
                end
            end
        end else if (instr[15:11] == `STORE) begin
            if (hit) begin
                hit_cnt <= hit_cnt + 1;
                if (way == 0) begin
                    cache0[index][15:0] <= d_dataout;   // write to cache
                    cache0[index][30:24] <= 0;          // clear cnt
                    cache1[index][30:24] <= cache1[index][30:24] + 1; // add the other way's cnt
                end else begin
                    cache1[index][15:0] <= d_dataout;
                    cache1[index][30:24] <= 0;
                    cache0[index][30:24] <= cache0[index][30:24] + 1;
                end
            end else begin
                miss_cnt <= miss_cnt + 1;
                hit_cnt <= hit_cnt - 1;
                if (cache0[index][31] == 0) begin
                    cache0[index][30:24] <= 0;              //  clear cnt
                    cache0[index][23:16] <= d_addr[15:7];   //  update tag
                    cache0[index][15:0] <= data_out;        //  store to cache
                    cache0[index][31] <= 1;                 //  set use bit
                end else if (cache1[index][31] == 0) begin
                    cache1[index][30:24] <= 0;
                    cache1[index][23:16] <= d_addr[15:7];
                    cache1[index][15:0] <= d_dataout;
                    cache1[index][31] <= 1;
                end else if (cache0[index][30:24] > cache1[index][30:24]) begin
                    cache0[index][30:24] <= 0;
                    cache0[index][23:16] <= d_addr[15:7];
                    cache0[index][15:0] <= d_dataout;
                end else begin
                    cache1[index][30:24] <= 0;
                    cache1[index][23:16] <= d_addr[15:7];
                    cache1[index][15:0] <= d_dataout;
                end
            end
        end
    end
end
endmodule

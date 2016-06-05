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

reg [31:0] hit_cnt;
reg [31:0] miss_cnt;

reg [31:0] cache0 [127:0];
reg [31:0] cache1 [127:0];

wire index;
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
        //for (i = 0; i < 128; i = i + 1) begin
        //    cache0[i] <= 0;
        //    cache1[i] <= 0;
        //end
    end
    else if (instr[15:11] == `LOAD) begin
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

endmodule

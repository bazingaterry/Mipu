`include "define.v"

module DP(
    input wire reset,
    input wire add,
    input wire select,
    input wire [15:0] memData,
    input wire [15:0] grData,
    output reg [7:0] address,
    output reg [15:0] data,
    output reg displayEnable
    );

always @ (posedge reset or posedge add) begin
	if (reset)
		address <= 8'b0000_0000;
	else
		address <= address + 1'b1;
end

always @ (*) begin
	if (select == `GR) begin
		if (address < 8) begin	//	gr size
			displayEnable <= 1;
			data <= grData;
		end else begin
			displayEnable <= 0;
			data <= 15'b0000_0000_0000_0000;
		end
	end else begin
		if (address < `MEM_SIZE) begin	//	mem size
			displayEnable <= 1;
			data <= memData;
		end else begin
			displayEnable <= 0;
			data <= 15'b0000_0000_0000_0000;
		end
	end
end

endmodule
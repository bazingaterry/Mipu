`include "define.v"

module DP(
    input wire reset,
    input wire add,
	input wire [7:0] pc,
    input wire [1:0] select,
	input wire flag,
    input wire [15:0] memData,
    input wire [15:0] grData,
    output reg [7:0] address,
    output reg [15:0] data,
    output reg displayEnable
    );

always @ (posedge reset or posedge add) begin
	if (reset)
		address <= 8'b0000_0000;
	else if (flag)
		address <= address + 1'b1;
	else
		address <= address - 1'b1;
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
	end else if (select == `MEM) begin
		if (address < `MEM_SIZE) begin	//	mem size
			displayEnable <= 1;
			data <= memData;
		end else begin
			displayEnable <= 0;
			data <= 15'b0000_0000_0000_0000;
		end
	end else if (select == `PC) begin
		displayEnable <= 1;
		data <= {8'b0000_0000, pc};
	end else begin
		displayEnable <= 1;
		data <= {8'b0000_0000, address};
	end
end

endmodule
module KEY (
	input wire BJ_CLK, // 3MHz Clock in
	input wire RESET,
	input wire BUTTON_IN,
	output wire BUTTON_OUT
);

reg [21:0] BJ_CLK_DIV; // 40Hz

always @ (posedge BJ_CLK or posedge RESET) begin
	if (RESET)
		BJ_CLK_DIV <= 0;
	else 
		BJ_CLK_DIV <= BJ_CLK_DIV + 1'b1;
end

reg BUTTON_IN_Q, BUTTON_IN_2Q, BUTTON_IN_3Q;

always @ (posedge BJ_CLK_DIV[21] or posedge RESET) begin
	if(RESET) begin
		BUTTON_IN_Q <= 1'b1;
		BUTTON_IN_2Q <= 1'b1;
		BUTTON_IN_3Q <= 1'b1;
	end	else begin
		BUTTON_IN_Q <= BUTTON_IN;
		BUTTON_IN_2Q <= BUTTON_IN_Q;
		BUTTON_IN_3Q <= BUTTON_IN_2Q;
	end
end
assign BUTTON_OUT = BUTTON_IN_2Q | BUTTON_IN_3Q;
endmodule
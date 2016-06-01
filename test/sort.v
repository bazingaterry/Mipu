`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:52:00 03/03/2016
// Design Name:   PC
// Module Name:   C:/Users/razer/OneDrive/Computer Architecture/PCPU/PCPU_with_MEM_imp/sort.v
// Project Name:  PCPU_with_MEM_imp
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sort;

	// Inputs
	reg clock;
	reg clk_reset;
	reg cpu_reset;
	reg mem_reset;
	reg start;
	reg enable;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
		.boardCLK(clock), 
		.cpu_reset(cpu_reset), 
		.clk_reset(clk_reset),
		.mem_reset(mem_reset),
		.start(start), 
		.enable(enable)
	);
	
	always #1 clock = ~clock;

	initial begin
		// Initialize Inputs
		clock = 0;
		cpu_reset = 0;
		clk_reset = 0;
		mem_reset = 0;
		start = 0;
		enable = 0;

		// Wait 50 ns for global reset to finish
		#50
		enable <= 1;
		start <= 0;
		cpu_reset = 1;
		clk_reset = 1;
		mem_reset = 1;
		
		#50 clk_reset = 0;
		#50 cpu_reset = 0;
        #50 mem_reset = 0;
		
		#50 enable = 1;
		#50 start = 1;
		#50 start = 0; 

	end
      
endmodule


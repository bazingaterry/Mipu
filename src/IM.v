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
		0: iout = {`ADDI,`gr7,4'd1,4'd0};              // gr7 <= 16'h10 for store address
		1: iout = {`LDIH,`gr1,4'b1011,4'b0110};        // test for LDIH  gr1<="16'hb600"
		2: iout = {`STORE,`gr1,1'b0,`gr7,4'h0};        // store to mem10 
		3: iout = {`LOAD,`gr1,1'b0,`gr0,4'h0};         // gr1 <= fffd 
		4: iout = {`LOAD,`gr2,1'b0,`gr0,4'h1};         // gr2 <= 4
		5: iout = {`ADDC,`gr3,1'b0,`gr1,1'b0,`gr2};    // gr3 <= fffd + 4 + cf(=0) = 1, cf<=1
		6: iout = {`STORE,`gr3,1'b0,`gr7,4'h1};        // store to mem11     
		7: iout = {`ADDC,`gr3,1'b0,`gr0,1'b0,`gr2};    // gr3 <= 0 + 4 + cf(=1) = 5, cf<=0
		8: iout = {`STORE,`gr3,1'b0,`gr7,4'h2};        // store to mem12
		9: iout = {`LOAD,`gr1,1'b0,`gr0,4'h2};          // gr1 <= 5 
		10: iout = {`SUBC,`gr3,1'b0,`gr1,1'b0,`gr2};    // gr3 <= 5 - 4 + cf(=0) =1, cf<=0    
		11: iout = {`STORE,`gr3,1'b0,`gr7,4'h3};        // store to mem13        
		12: iout = {`SUB,`gr3,1'b0,`gr2,1'b0,`gr1};     // gr3 <= 4 - 5 = -1, cf<=1    
		13: iout = {`STORE,`gr3,1'b0,`gr7,4'h4};        // store to mem14        
		14: iout = {`SUBC,`gr3,1'b0,`gr2,1'b0,`gr1};    // gr3 <= 5 - 4 - cf(=1) =2, cf<=0 
		15: iout = {`STORE,`gr3,1'b0,`gr7,4'h5};        // store to mem15        
		16: iout = {`LOAD,`gr1,1'b0,`gr0,4'h3};         // gr1 <= c369
		17: iout = {`LOAD,`gr2,1'b0,`gr0,4'h4};         // gr2 <= 69c3       
		18: iout = {`AND,`gr3,1'b0,`gr1,1'b0,`gr2};     // gr3 <= gr1 & gr2 = 4141
		19: iout = {`STORE,`gr3,1'b0,`gr7,4'h6};        // store to mem16        
		20: iout = {`OR,`gr3,1'b0,`gr1,1'b0,`gr2};      // gr3 <= gr1 | gr2 = ebeb
		21: iout = {`STORE,`gr3,1'b0,`gr7,4'h7};        // store to mem17        
		22: iout = {`XOR,`gr3,1'b0,`gr1,1'b0,`gr2};     // gr3 <= gr1 ^ gr2 = aaaa
		23: iout = {`STORE,`gr3,1'b0,`gr7,4'h8};        // store to mem18
		24: iout = {`SLL,`gr3,1'b0,`gr1,4'h0};          // gr3 <= gr1 < 0 
		25: iout = {`STORE,`gr3,1'b0,`gr7,4'h9};        // store to mem19        
		26: iout = {`SLL,`gr3,1'b0,`gr1,4'h1};          // gr3 <= gr1 < 1 
		27: iout = {`STORE,`gr3,1'b0,`gr7,4'ha};        // store to mem1a        
		28: iout = {`SLL,`gr3,1'b0,`gr1,4'h4};          // gr3 <= gr1 < 8 
		29: iout = {`STORE,`gr3,1'b0,`gr7,4'hb};        // store to mem1b    
		30: iout = {`SLL,`gr3,1'b0,`gr1,4'hf};          // gr3 <= gr1 < 15 
		31: iout = {`STORE,`gr3,1'b0,`gr7,4'hc};        // store to mem1c
		32: iout = {`SRL,`gr3,1'b0,`gr1,4'h0};          // gr3 <= gr1 > 0
		33: iout = {`STORE,`gr3,1'b0,`gr7,4'hd};        // store to mem1d        
		34: iout = {`SRL,`gr3,1'b0,`gr1,4'h1};          // gr3 <= gr1 > 1
		35: iout = {`STORE,`gr3,1'b0,`gr7,4'he};        // store to mem1e        
		36: iout = {`SRL,`gr3,1'b0,`gr1,4'h8};          // gr3 <= gr1 > 8
		37: iout = {`STORE,`gr3,1'b0,`gr7,4'hf};        // store to mem1f        
		38: iout = {`SRL,`gr3,1'b0,`gr1,4'hf};          // gr3 <= gr1 > 15
		39: iout = {`ADDI,`gr7,4'd1,4'd0};              // gr7 <= 16'h20 for store address
		40: iout = {`STORE,`gr3,1'b0,`gr7,4'h0};        // store to mem20
		41: iout = {`SLA,`gr3,1'b0,`gr1,4'h0};          // gr3 <= gr1 < 0
		42: iout = {`STORE,`gr3,1'b0,`gr7,4'h1};        // store to mem21
		43: iout = {`SLA,`gr3,1'b0,`gr1,4'h1};          // gr3 <= gr1 < 1 
		44: iout = {`STORE,`gr3,1'b0,`gr7,4'h2};        // store to mem22
		45: iout = {`SLA,`gr3,1'b0,`gr1,4'h8};          // gr3 <= gr1 < 8 
		46: iout = {`STORE,`gr3,1'b0,`gr7,4'h3};        // store to mem23
		47: iout = {`SLA,`gr3,1'b0,`gr1,4'hf};          // gr3 <= gr1 < 15
		48: iout = {`STORE,`gr3,1'b0,`gr7,4'h4};        // store to mem24
		49: iout = {`SLA,`gr3,1'b0,`gr2,4'h0};          // gr3 <= gr1 < 0
		50: iout = {`STORE,`gr3,1'b0,`gr7,4'h5};        // store to mem25
		51: iout = {`SLA,`gr3,1'b0,`gr2,4'h1};          // gr3 <= gr1 < 1
		52: iout = {`STORE,`gr3,1'b0,`gr7,4'h6};        // store to mem26
		53: iout = {`SLA,`gr3,1'b0,`gr2,4'h8};          // gr3 <= gr1 < 8
		54: iout = {`STORE,`gr3,1'b0,`gr7,4'h7};        // store to mem27
		55: iout = {`SLA,`gr3,1'b0,`gr2,4'hf};          // gr3 <= gr1 < 15
		56: iout = {`STORE,`gr3,1'b0,`gr7,4'h8};        // store to mem28
		57: iout = {`SRA,`gr3,1'b0,`gr1,4'h0};          // gr3 <= gr1 > 0
		58: iout = {`STORE,`gr3,1'b0,`gr7,4'h9};        // store to mem29
		59: iout = {`SRA,`gr3,1'b0,`gr1,4'h1};          // gr3 <= gr1 > 1
		60: iout = {`STORE,`gr3,1'b0,`gr7,4'ha};        // store to mem2a
		61: iout = {`SRA,`gr3,1'b0,`gr1,4'h8};          // gr3 <= gr1 > 8
		62: iout = {`STORE,`gr3,1'b0,`gr7,4'hb};        // store to mem2b
		63: iout = {`SRA,`gr3,1'b0,`gr1,4'hf};          // gr3 <= gr1 > 15
		64: iout = {`STORE,`gr3,1'b0,`gr7,4'hc};        // store to mem2c
		65: iout = {`SRA,`gr3,1'b0,`gr2,4'h0};          // gr3 <= gr1 > 0
		66: iout = {`STORE,`gr3,1'b0,`gr7,4'hd};        // store to mem2d
		67: iout = {`SRA,`gr3,1'b0,`gr2,4'h1};          // gr3 <= gr1 > 1
		68: iout = {`STORE,`gr3,1'b0,`gr7,4'he};        // store to mem2e
		69: iout = {`SRA,`gr3,1'b0,`gr2,4'h8};          // gr3 <= gr1 > 8
		70: iout = {`STORE,`gr3,1'b0,`gr7,4'hf};        // store to mem2f
		71: iout = {`ADDI,`gr7,4'd1,4'd0};              // gr7 <= 16'h30 for store address
		72: iout = {`SRA,`gr3,1'b0,`gr2,4'hf};          // gr3 <= gr1 > 15
		73: iout = {`STORE,`gr3,1'b0,`gr7,4'h0};        // store to mem30        
		74: iout = {`LOAD,`gr1,1'b0,`gr0,4'h5};         // gr1 <= 41
		75: iout = {`LOAD,`gr2,1'b0,`gr0,4'h6};         // gr2 <= ffff
		76: iout = {`LOAD,`gr3,1'b0,`gr0,4'h7};         // gr3 <= 1
		77: iout = {`JUMP, 3'd0,8'h4f};                 // jump to 4f
		78: iout = {`STORE,`gr7,1'b0,`gr7,4'h1};        // store to mem31
		79: iout = {`JMPR, `gr1,8'h10};                 // jump to 41+10 = 51
		80: iout = {`STORE,`gr7,1'b0,`gr7,4'h2};        // store to mem32
		81: iout = {`ADD, `gr4,1'b0,`gr2,1'b0,`gr3};    // gr4<= ffff + 1,cf<=1
		82: iout = {`BNC,`gr1,8'h28};                   // if(cf==0) jump to 69
		83: iout = {`BC,`gr1,8'h14};                    // if(cf==1) jump to 55
		84: iout = {`STORE,`gr7,1'b0,`gr7,4'h3};        // store to mem33
		85: iout = {`ADD, `gr4,1'b0,`gr3,1'b0,`gr3};    // gr4<= 1 + 1 , cf<=0
		86: iout = {`BC,`gr1,8'h28};                    // if(cf==1) jump to 69
		87: iout = {`BNC,`gr1,8'h18};                   // if(cf==0) jump to 59
		88: iout = {`STORE,`gr7,1'b0,`gr7,4'h4};        // store to mem34
		89: iout = {`CMP, 3'd0,1'b0,`gr3,1'b0,`gr3};    // 1-1=0 , zf<=1,nf<=0
		90: iout = {`BNZ,`gr1,8'h28};                   // if(zf==0) jump to 69
		91: iout = {`BZ,`gr1,8'h1c};                    // if(zf==1) jump to 5d
		92: iout = {`STORE,`gr7,1'b0,`gr7,4'h5};        // store to mem35
		93: iout = {`CMP, 3'd0,1'b0,`gr4,1'b0,`gr3};    // 2-1=1 , zf<=0,nf<=0 
		94: iout = {`BZ,`gr1,8'h28};                    // if(zf==1) jump to 69
		95: iout = {`BNZ,`gr1,8'h20};                   // if(zf==0) jump to 61
		96: iout = {`STORE,`gr7,1'b0,`gr7,4'h6};        // store to mem36
		97: iout = {`CMP, 3'd0,1'b0,`gr3,1'b0,`gr4};    // 1-2=-1, nf<=1,zf<=0
		98: iout = {`BNN,`gr1,8'h28};                   // if(nf==0) jump to 69
		99: iout = {`BN,`gr1,8'h24};                    // if(nf==1) jump to 65 
		100: iout = {`STORE,`gr7,1'b0,`gr7,4'h7};        // store to mem37
		101: iout = {`CMP, 3'd0,1'b0,`gr4,1'b0,`gr3};    // 2-1=1, nf<=0,zf<=0
		102: iout = {`BN,`gr1,8'h28};                    // if(nf==1) jump to 69
		103: iout = {`BNN,`gr1,8'h27};                   // if(nf==0) jump to 68
		104: iout = {`STORE,`gr7,1'b0,`gr7,4'h8};        // store to mem38
		105: iout = {`HALT, 11'd0};  
		default : iout = {`HALT, 11'd0};
	endcase
end
endmodule

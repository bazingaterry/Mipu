`timescale 1ns / 1ps
`include "../define.v"

module control_test;

    // Inputs
    reg clock;
    reg [15:0] d_datain;
    reg enable;
    reg [15:0] i_datain;
    reg reset;
    reg start;

    // Outputs
    wire [7:0] d_addr;
    wire [15:0] d_dataout;
    wire d_we;
    wire [7:0] i_addr;

    // Instantiate the Unit Under Test (UUT)
    PCPU uut (
        .clock(clock), 
        .d_datain(d_datain), 
        .enable(enable), 
        .i_datain(i_datain), 
        .reset(reset), 
        .start(start), 
        .d_addr(d_addr), 
        .d_dataout(d_dataout), 
        .d_we(d_we), 
        .i_addr(i_addr)
    );

    always #5 clock = ~clock;

    initial begin
        // Initialize Inputs
        clock = 0;
        d_datain = 0;
        enable = 0;
        i_datain = 0;
        reset = 0;
        start = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Add stimulus here
        $display("pc:     id_ir      :regA:regB:regC:da:dd  :dwe:reC1:gr0 :gr1 :gr2 :gr3 :gr4 :gr5 :gr6 :gr7 :zf:cf:nf");
        $monitor("%h:%b:%h:%h:%h:%h:%h:%3b:%h:%h:%h:%h:%h:%h:%h:%h:%h:%2h:%2h:%2h", 
            uut.IF.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            d_addr, d_dataout, d_we, uut.reg_C1,
            uut.gr[0], uut.gr[1], uut.gr[2], uut.gr[3], uut.gr[4], uut.gr[5], uut.gr[6], uut.gr[7], uut.zf, uut.cf, uut.nf);
            
        enable <= 1; start <= 0; i_datain <= 0; d_datain <= 0;

        #10 reset    <= 0;
        #10 reset    <= 1;
        #10 enable   <= 1;
        #10 start    <= 1;
        #10 start    <= 0;
            i_datain <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
		#10 i_datain <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0000};
        #10 i_datain <= {`JUMP, 3'b000, 8'b00001111}; //  pc = 0f
        #10 i_datain <= {`JMPR, `gr1, 8'b00000001}; //  pc = 000b + 1 = 0c
            d_datain <= 16'h000b;
        #10 i_datain <= {`JUMP, 3'b000, 8'b00001111}; //  flush
            d_datain <= 16'h011b;
        #10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
		#10 i_datain <= {`HALT, 11'b000_0000_0000};// flush
        #10 i_datain <= {`CMP, 3'b000, 1'b0, `gr1, 1'b0, `gr2}; // nf = 1, cf = 1
        #10 i_datain <= {`BZ, `gr1, 8'b00000111}; //  not jump
        #10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // pc = 000b + 1f = 2a
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
		#10 i_datain <= {`HALT, 11'b000_0000_0000};// flush
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
        #10 i_datain <= {`BN, `gr1, 8'b00111111}; // pc = 000b + 3f = 4a
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
		#10 i_datain <= {`HALT, 11'b000_0000_0000};// flush
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
        #10 i_datain <= {`BNN, `gr1, 8'b01111111}; // not jump
        #10 i_datain <= {`BC, `gr1, 8'b11111111}; // pc = 000b + ff = 0a
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
		#10 i_datain <= {`HALT, 11'b000_0000_0000};// flush
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
        #10 i_datain <= {`BNC, `gr1, 8'b01111111}; // not jump
        #10 i_datain <= {`CMP, 3'b000, 1'b0, `gr1, 1'b0, `gr1}; // zf = 1
        #10 i_datain <= {`BZ, `gr1, 8'b00111111}; //  pc = 000b + 3f = 4a
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
		#10 i_datain <= {`HALT, 11'b000_0000_0000};// flush
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
        #10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // not jump
        #10 i_datain <= {`BN, `gr1, 8'b00001111}; // not jump
        #10 i_datain <= {`BNN, `gr1, 8'b00000111}; // pc = 000b + 7 = 12
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
		#10 i_datain <= {`HALT, 11'b000_0000_0000};// flush
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
        #10 i_datain <= {`BC, `gr1, 8'b00000011}; // not jump
        #10 i_datain <= {`BNC, `gr1, 8'b00000001}; // pc = 000b + 1 = 0c
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
		#10 i_datain <= {`HALT, 11'b000_0000_0000};// flush
		#10 i_datain <= {`BNZ, `gr1, 8'b00011111}; // flush
        #10 i_datain <= {`HALT, 11'b000_0000_0000};

    end
      
endmodule
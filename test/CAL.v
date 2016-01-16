`timescale 1ns / 1ps
`include "../define.v"

module cal_test;

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
        //  Data transfer & Arithmetic
        #10 reset    <= 0;
        #10 reset    <= 1;
        #10 enable   <= 1;
        #10 start    <= 1;
        #10 start    <= 0;
            i_datain <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
		#10 i_datain <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
		#10 i_datain <= {`LOAD, `gr3, 1'b0, `gr0, 4'b0010};
		#10 i_datain <= {`NOP, 11'b000_0000_0000};
		    d_datain <= 16'hcccc;
		#10 i_datain <= {`NOP, 11'b000_0000_0000};
		    d_datain <= 16'h3bfe;
		#10 i_datain <= {`NOP, 11'b000_0000_0000};
		    d_datain <= 16'h00ab;
		#10 i_datain <= {`ADDI, `gr2, 4'b0000,  4'b0010}; //gr2 = 2 + 3bfe = 3c00
		#10 i_datain <= {`LDIH, `gr1, 4'b1111, 4'b1100};  //gr1 = cccc + fc00 = c8cc & cf = 1 & nf = 1
		#10 i_datain <= {`NOP, 11'b000_0000_0000};
		#10 i_datain <= {`NOP, 11'b000_0000_0000};
		#10 i_datain <= {`ADDC, `gr3, 1'b0, `gr2, 1'b0, `gr3}; // gr3 = 00ab + 3c00 + cf = 3cac
		#10 i_datain <= {`SUB, `gr1, 1'b0, `gr2, 1'b0, `gr2};// gr1 = 3c00 - 3c00 = 0 & zf = 1
        #10 i_datain <= {`NOP, 11'b000_0000_0000};
        #10 i_datain <= {`NOP, 11'b000_0000_0000};
        #10 i_datain <= {`ADD, `gr4, 1'b0, `gr2, 1'b0, `gr3};// gr4 = 3c00 + 3cac = 78ac
        #10 i_datain <= {`CMP, 4'b0000, `gr2, 1'b0, `gr3};//  3c00 - 3cac = ff54, zf = 1, nf = 1
		#10 i_datain <= {`SUBI, `gr5, 8'b11111111};// gr5 = 0 - 00ff = ff01, nf = 1, cf = 1
		#10 i_datain <= {`SUBC, `gr6, 1'b0, `gr2, 1'b0, `gr3}; // gr6 = 3c00 - 3cac - cf = ff53, nf = 1, cf = 1
		#10 i_datain <= {`STORE, `gr2, 1'b0, `gr0, 4'b0100}; //   addr = 04, data = 3c00
		#10 i_datain <= {`HALT, 11'b000_0000_0000};
    end
      
endmodule
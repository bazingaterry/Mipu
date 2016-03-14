`timescale 1ns / 1ps
`include "../define.v"

module log_test;

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
        #10 i_datain <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
        #10 i_datain <= {`LOAD, `gr3, 1'b0, `gr0, 4'b0010};
        #10 i_datain <= {`AND, `gr4, 1'b0, `gr1, 1'b0, `gr2}; //  gr4 = 13ab and 14cc = 1088
            d_datain <= 16'h13ab;
        #10 i_datain <= {`OR, `gr5, 1'b0, `gr1, 1'b0, `gr2}; //  gr5 = 13ab or 14cc = 17ef
            d_datain <= 16'h14cc;
        #10 i_datain <= {`XOR, `gr6, 1'b0, `gr1, 1'b0, `gr2}; // gr6 = 13ab xor 14cc = 0767
            d_datain <= 16'h8001;
        #10 i_datain <= {`SLL, `gr7, 1'b0, `gr4, 4'b0010}; //  gr7 = 1088 << 2 = 4220
        #10 i_datain <= {`SRL, `gr6, 1'b0, `gr4, 4'b0010}; //  gr6 = 1088 >> 2 = 0422
        #10 i_datain <= {`SLA, `gr7, 1'b0, `gr5, 4'b0010}; //  gr7 = 17ef <<< 2 = 5fbc
        #10 i_datain <= {`SRA, `gr6, 1'b0, `gr5, 4'b0010}; //  gr6 = 17ef >>> 2 = 05fb
        #10 i_datain <= {`SLL, `gr7, 1'b0, `gr3, 4'b0010}; //  gr7 = 8001 << 2 = 0004
        #10 i_datain <= {`SRL, `gr6, 1'b0, `gr3, 4'b0010}; //  gr6 = 8001 >> 2 = 2000
        #10 i_datain <= {`SLA, `gr7, 1'b0, `gr3, 4'b0010}; //  gr7 = 8001 <<< 2 = 0004
        #10 i_datain <= {`SRA, `gr6, 1'b0, `gr3, 4'b0010}; //  gr6 = 8001 >>> 2 = e000
        #10 i_datain <= {`HALT, 11'b000_0000_0000};

    end
      
endmodule
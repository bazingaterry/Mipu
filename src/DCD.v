module DCD(
    input wire reset,
    input wire clk,
    input wire [15:0] data,
    input wire enable,
    output reg [6:0] display,
    output reg [3:0] enableSignal
    );

reg [1:0] count;

reg [15:0] myclk;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
         myclk <= 0;
    end
    else begin
        myclk <= myclk + 1'b1;
    end
end

always @ (posedge myclk[12] or posedge reset) begin
    if (reset) begin
         count <= 2'b00;
    end
    else begin
        count <= count + 1'b1;
    end
end

reg [3:0] currentDisplay;

always @ (*) begin
    case(count)
        2'b00 : currentDisplay <= data[3:0];
        2'b01 : currentDisplay <= data[7:4];
        2'b10 : currentDisplay <= data[11:8];
        2'b11 : currentDisplay <= data[15:12];
    endcase
end

reg [3:0] en;

always @ (*) begin
    case(count)
        2'b00 : en <= 4'b1110;
        2'b01 : en <= 4'b1101;
        2'b10 : en <= 4'b1011;
        2'b11 : en <= 4'b0111;
    endcase
end

always @ (*) begin
    if (enable)
        enableSignal <= en;
    else
        enableSignal <= 4'b1111;
end

always @ (*) begin
    case(currentDisplay[3:0])
        4'b0000 : display = 7'b0000001;
        4'b0001 : display = 7'b1001111;
        4'b0010 : display = 7'b0010010;
        4'b0011 : display = 7'b0000110;
        4'b0100 : display = 7'b1001100;
        4'b0101 : display = 7'b0100100;
        4'b0110 : display = 7'b0100000;
        4'b0111 : display = 7'b0001111;
        4'b1000 : display = 7'b0000000;
        4'b1001 : display = 7'b0000100;
        4'b1010 : display = 7'b0001000;
        4'b1011 : display = 7'b1100000;
        4'b1100 : display = 7'b0110001;
        4'b1101 : display = 7'b1000010;
        4'b1110 : display = 7'b0110000;
        4'b1111 : display = 7'b0111000;
        default : display = 7'b1111111;
    endcase
end
endmodule
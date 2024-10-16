`default_nettype none
// Empty top module

module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // Ports from/to UART
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);

  // Your code goes here...
  ssdec sd(.in(right[3:0]), .enable(green), .out(ss0[6:0]));
  prienc16to4 u1(.in(pb[15:0]), .out(right[3:0]), .strobe(green));

endmodule

// Add more modules down here...

// prienc16to4 Module
module prienc16to4(input logic [15:0] in, output logic [3:0] out, output logic strobe);
  assign strobe = |in[15:0];
  assign out = in[15] == 1 ? 4'b1111:
               in[14] == 1 ? 4'b1110:
               in[13] == 1 ? 4'b1101:
               in[12] == 1 ? 4'b1100:
               in[11] == 1 ? 4'b1011:
               in[10] == 1 ? 4'b1010:
               in[9] == 1 ? 4'b1001:
               in[8] == 1 ? 4'b1000:
               in[7] == 1 ? 4'b0111:
               in[6] == 1 ? 4'b0110:
               in[5] == 1 ? 4'b0101:
               in[4] == 1 ? 4'b0100:
               in[3] == 1 ? 4'b0011:
               in[2] == 1 ? 4'b0010:
               in[1] == 1 ? 4'b0001: 4'b0000;

endmodule


// ssdec Module
module ssdec(input logic[3:0] in, output logic [6:0] out, input logic enable);

logic [15:0] SEGA, SEGB, SEGC, SEGD, SEGE, SEGF, SEGG;

assign SEGA = 16'b1101011111101101;
assign SEGB = 16'b0010011110011111;
assign SEGC = 16'b0010111111111011;
assign SEGD = 16'b0111100101101101;
assign SEGE = 16'b1111110101000101;
assign SEGF = 16'b1101111101110001;
assign SEGG = 16'b1110111101111100;

assign out[0] = (enable == 1)? SEGA[in]: 0;
assign out[1] = (enable == 1)? SEGB[in]: 0;
assign out[2] = (enable == 1)? SEGC[in]: 0;
assign out[3] = (enable == 1)? SEGD[in]: 0;
assign out[4] = (enable == 1)? SEGE[in]: 0;
assign out[5] = (enable == 1)? SEGF[in]: 0;
assign out[6] = (enable == 1)? SEGG[in]: 0;

endmodule
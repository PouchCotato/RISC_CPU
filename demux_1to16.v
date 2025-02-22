`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 13:53:05
// Design Name: 
// Module Name: demux_1x16
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module demux_1x16#(parameter L = 16,sel_L = 4,word_L = 16)(
    input [word_L-1:0] Din,
    input [sel_L-1:0] sel,
    output reg [0:L-1][word_L-1:0] Dout
    );
    integer  x;
    always @(*) begin
    for(x = 0;x < L; x = x + 1) begin
    if(x == sel) Dout[x] <= Din;
    else Dout[x] <= 0; 
    end
    end
endmodule



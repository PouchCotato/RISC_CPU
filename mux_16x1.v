`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 13:32:23
// Design Name: 
// Module Name: mux_16x1
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


module mux_16x1 #(parameter L = 16,sel_L = 4,word_L = 16)(
    input [0:L-1][word_L-1:0] Din,
    input [sel_L-1:0] sel,
    output reg [word_L-1:0] Dout
    );
    always @(*) begin
        Dout = Din[sel];
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2024 23:03:33
// Design Name: 
// Module Name: incrementor
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


module incrementor(
    input [15:0] Din,
    output reg [15:0] Dout
    );
always @(Din) begin
    Dout <= Din + 16'b0000000000000001;
end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 16:38:22
// Design Name: 
// Module Name: registers
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


module register16bit(
    input W,clk,rst,
    input [15:0] Din,
    output [15:0] Dout
    );
    reg [15:0] D,Dout1;
    always @(posedge clk)
    begin
    if (rst==1'b1) begin
        D <= 16'b0000000000000000; end
    else if (W == 1'b1) begin
        D <= Din; end
    else begin
        D<=D; end
    end
    assign Dout = D;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 13:17:04
// Design Name: 
// Module Name: decoder4to16
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


module decoder4to16 #(ip_L = 4)(
    input [ip_L-1:0] Din,
    output reg [2**ip_L - 1:0] Dout
    );
    integer x;
always @(Din) begin
    for(x = 0;x < (1<<ip_L); x = x + 1) begin
    if(x == Din) Dout[x] <= 1;
    else Dout[x] <= 0;
    end
end
endmodule

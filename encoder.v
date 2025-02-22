`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2024 22:17:30
// Design Name: 
// Module Name: encoder
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


module encoder #(op_L = 4)(
    output reg [op_L-1:0] Dout,
    input [2**op_L - 1:0] Din
    );
    integer x;
always @(Din) begin
    for(x = 0;x < (1<<op_L); x = x + 1) begin
    if(Din[x] == 1'b1) Dout <= x;
    end
end
endmodule
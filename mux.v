`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Companout: 
// Engineer: 
// 
// Create Date: 24.11.2024 02:36:00
// Design Name: 
// Module Name: mux
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


module mux(output reg out, 
           input D0, D1, D2, D3, D4, D5, D6, D7, 
           input [2:0] S);
always @(*) begin
        case (S)
            3'b000: out = D0;
            3'b001: out = D1;
            3'b010: out = D2;
            3'b011: out = D3;
            3'b100: out = D4;
            3'b101: out = D5;
            3'b110: out = D6;
            3'b111: out = D7;
            default: out = 1'b0; // Default to 0 for safetout
        endcase
    end
endmodule

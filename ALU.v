`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 14:40:10
// Design Name: 
// Module Name: ALU
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


module ALU(
    input FLGON, EN,
    input [2:0] OP,
    input [15:0] D1,D2,
    output reg [15:0] ALUREG,
    output reg [1:0] FLG
    );
    reg [15:0] ALUREG1;
    always @(*) begin
    if (EN == 1)
        begin
        if (FLGON == 0)
        begin
            case (OP)
                3'b000 : ALUREG <= D1 + D2;
                3'b001 : ALUREG <= D1 - D2;
                3'b010 : ALUREG <= D1 & D2;
                3'b011 : ALUREG <= D1 | D2;
                3'b100 : ALUREG <= ~D1;
            endcase
        end
        else
        begin
                ALUREG1<= D1 - D2;
                if (ALUREG1[15] == 1'b1) FLG[0] <= 1'b1;
                else FLG[0] <= 1'b0;
                if (ALUREG1 == 0) FLG[1] <= 1'b1;
                else FLG[1] <= 1'b0;
        end
        end
    end
endmodule


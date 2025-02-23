`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2024 21:55:54
// Design Name: 
// Module Name: CROM
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


module CROM(
    input read,rst,
    input [7:0] read_addr,
    output reg [15:0] rd_data 
    );
    parameter ADDR_WIDTH = 8;
    parameter mem_size = 255;
    parameter DATA_WIDTH = 15;
    reg [DATA_WIDTH:0] temp_mem[0:mem_size];
    always @(*)
    begin
    if (read) rd_data<=temp_mem[read_addr];
    end
    always @(posedge rst) begin
    temp_mem[8'b0000_0000] <= 16'b0001_0001_0000_0000;
    temp_mem[8'b0000_0001] <= 16'b1011_0011_0000_0000;
    temp_mem[8'b0000_0010] <= 16'b0000_0000_0000_1000;
    
    temp_mem[8'b0011_0000] <= 16'b0001_0100_0111_0001;
    temp_mem[8'b0011_0001] <= 16'b0001_0101_1010_0001;
    temp_mem[8'b0011_0010] <= 16'b0110_0000_0000_0000;
    temp_mem[8'b0011_0011] <= 16'b0001_1101_0010_0110;

    temp_mem[8'b0100_0000] <= 16'b0001_0100_0111_0001;
    temp_mem[8'b0100_0001] <= 16'b0001_0101_1010_0001;
    temp_mem[8'b0100_0010] <= 16'b1010_0000_0000_0000;
    temp_mem[8'b0100_0011] <= 16'b0001_1101_0010_0110;

    temp_mem[8'b1000_0000] <= 16'b0001_0100_0111_0001;
    temp_mem[8'b1000_0001] <= 16'b0111_0000_0000_0000;
    temp_mem[8'b1000_0010] <= 16'b1000_0000_0000_0000;
    temp_mem[8'b1000_0011] <= 16'b0001_1101_0010_0110;

    temp_mem[8'b1001_0000] <= 16'b0001_0100_0111_0001;
    temp_mem[8'b1001_0001] <= 16'b0001_0101_1010_0001;
    temp_mem[8'b1001_0010] <= 16'b0111_0000_0000_0000;
    temp_mem[8'b1001_0011] <= 16'b0001_1101_0010_0110;

    temp_mem[8'b1010_0000] <= 16'b0001_0100_0111_0001;
    temp_mem[8'b1010_0001] <= 16'b1001_0000_0000_0000;
    temp_mem[8'b1010_0010] <= 16'b0001_1101_0010_0110;

    temp_mem[8'b0101_0000] <= 16'b0001_0001_1010_0001;
    temp_mem[8'b0101_0001] <= 16'b1011_0111_0000_0110;

    temp_mem[8'b0110_0000] <= 16'b0001_0001_1010_0001;
    temp_mem[8'b0110_0001] <= 16'b1100_0000_0111_0101;

    temp_mem[8'b0111_0000] <= 16'b0010_0000_0000_0100;

    temp_mem[8'b0001_0000] <= 16'b0001_0000_0111_0101;

    temp_mem[8'b1100_0000] <= 16'b0011_0000_0000_1000;
    
    temp_mem[8'b1101_0000] <= 16'b1101_0000_0000_0100;
    
    temp_mem[8'b0010_0000] <= 16'b0001_0100_0111_0001;
    temp_mem[8'b0010_0001] <= 16'b0001_0101_1010_0001;
    temp_mem[8'b0010_0010] <= 16'b1010_0000_0000_0000;
    temp_mem[8'b0010_0011] <= 16'b0101_0000_0000_0100;

    temp_mem[8'b1011_0000] <= 16'b0001_0111_1010_0111;

    temp_mem[8'b1110_0000] <= 16'b0001_0111_0000_0110;

    temp_mem[8'b1111_0000] <= 16'b0001_0000_0111_0110;
    end
endmodule
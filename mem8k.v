`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 16:02:55
// Design Name: 
// Module Name: mem8k
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


module mem8k(
    input clk,
    input read,
    input write,rst,
    input [15:0] wr_data,
    input [12:0] write_addr, read_addr,
    output reg [15:0] rd_data,
    output reg wr_done,rd_done,
    output o1,o2,o3,o4
    );
    parameter ADDR_WIDTH = 13;
    parameter mem_size = 600;
    //parameter mem_size = 8191;
    parameter DATA_WIDTH = 15;
    reg [DATA_WIDTH:0] temp_mem[0:mem_size];
    always @(*)
    begin
        if (rst) begin
        temp_mem[0] = 16'b1101_000_000_000_000;
        temp_mem[1] = 16'b1101_000_001_000_001;
        temp_mem[2] = 16'b1101_000_011_000_111;
        temp_mem[3] = 16'b1101_111_100_111_111;
        temp_mem[4] = 16'b1101_000_101_001_100;
        temp_mem[5] = 16'b1101_000_110_000_001;
        temp_mem[6] = 16'b1101_000_111_000_000;
        temp_mem[7] = 16'b0110_000_000_100_000;
        temp_mem[8] = 16'b0011_000_000_001_010;
        temp_mem[9] = 16'b0011_000_111_110_111;
        temp_mem[10] = 16'b0011_000_100_110_100;
        temp_mem[11] = 16'b1011_000_000_001_000;
        temp_mem[12] = 16'b1011_000_001_010_000;
        temp_mem[13] = 16'b0010_000_111_101_000;
        temp_mem[14] = 16'b0111_010_000_000_000;
        temp_mem[15] = 16'b0001_000_011_000_000;
        temp_mem[16] = 16'b1100_000_000_000_000;
        end 
        else begin
                if (write)
                    begin 
                        temp_mem[write_addr]<=wr_data;
                        wr_done <=1;

                    end
                else wr_done<=0;
                if (read)
                    begin
                        rd_data<=temp_mem[read_addr];
                        rd_done<=1;
                    end
                 else rd_done<=0;
        end
        end
              assign          o4 = temp_mem[518][3];
              assign          o3 = temp_mem[518][2];
              assign          o2 = temp_mem[518][1];
              assign          o1 = temp_mem[518][0];
endmodule

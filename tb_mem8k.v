`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 16:11:21
// Design Name: 
// Module Name: tb_mem8k
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
module tb_mem8k;

    // Testbench signals
    reg clk;
    reg rst;
    reg read;
    reg write;
    reg [15:0] wr_data;
    reg [12:0] write_addr, read_addr;  // Updated address width to 13 bits
    wire [15:0] rd_data;
    wire wr_done, rd_done;

    // Instantiate the mem8k module
    mem8k uut (
        .clk(clk),
        .rst(rst),
        .read(read),
        .write(write),
        .wr_data(wr_data),
        .write_addr(write_addr),
        .read_addr(read_addr),
        .rd_data(rd_data),
        .wr_done(wr_done),
        .rd_done(rd_done)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Clock with 10ns period (100 MHz)
    end

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        read = 0;
        write = 0;
        wr_data = 0;
        write_addr = 0;
        read_addr = 0;

        // Apply Reset
        $display("Test 1: Reset");
        rst = 1;
        #10;  // Hold reset for 10 ns
        rst = 0;
        #10;  // Wait for 10 ns

        // Test case 1: Write data to address 5
        $display("Test 2: Write data to address 5");
        write = 1;
        wr_data = 16'hABCD;   // Data to write
        write_addr = 13'd5;   // Address to write to
        #10;  // Wait for 1 clock cycle
        write = 0;            // End write operation
        #10;  // Wait for 1 clock cycle
        $display("wr_done = %b", wr_done);

        // Test case 2: Read data from address 5
        $display("Test 3: Read data from address 5");
        read = 1;
        read_addr = 13'd5;  // Address to read from
        #10;  // Wait for 1 clock cycle
        read = 0;           // End read operation
        #10;  // Wait for 1 clock cycle
        $display("rd_data = %h, rd_done = %b", rd_data, rd_done);

        // Test case 3: Write data to address 100
        $display("Test 4: Write data to address 100");
        write = 1;
        wr_data = 16'h1234;   // New data to write
        write_addr = 13'd100; // Address to write to
        #10;  // Wait for 1 clock cycle
        write = 0;            // End write operation
        #10;  // Wait for 1 clock cycle

        // Test case 4: Read data from address 100
        $display("Test 5: Read data from address 100");
        read = 1;
        read_addr = 13'd100;  // Address to read from
        #10;  // Wait for 1 clock cycle
        read = 0;             // End read operation
        #10;  // Wait for 1 clock cycle
        $display("rd_data = %h, rd_done = %b", rd_data, rd_done);

        // Test case 5: Write and read multiple locations
        $display("Test 6: Write and read multiple locations");
        write = 1;
        wr_data = 16'hDEAD;
        write_addr = 13'd255;
        #10;
        write = 0;
        #10;
        read = 1;
        read_addr = 13'd255;
        #10;
        read = 0;
        #10;
        $display("rd_data = %h, rd_done = %b", rd_data, rd_done);

        // Test case 6: Reset the memory and check if rd_data is reset
        $display("Test 7: Reset and check read data");
        rst = 1;
        #10;  // Wait for reset to propagate
        rst = 0;
        read = 1;
        read_addr = 13'd5;  // Read previously written data
        #10;
        read = 0;
        #10;
        $display("rd_data = %h, rd_done = %b", rd_data, rd_done);

        // Test case 7: Test the edge case with max address 8191
        $display("Test 8: Write and read at max address (8191)");
        write = 1;
        wr_data = 16'hFFFF;   // Data to write
        write_addr = 13'd8191; // Maximum address (8191)
        #10;
        write = 0;
        #10;
        read = 1;
        read_addr = 13'd8191;  // Max address to read from
        #10;
        read = 0;
        #10;
        $display("rd_data = %h, rd_done = %b", rd_data, rd_done);

        // End the test
        $finish;
    end
endmodule

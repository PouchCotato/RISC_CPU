`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 15:54:34
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;

    // Testbench signals
    reg FLGON;
    reg EN;
    reg [2:0] OP;
    reg [15:0] D1, D2;
    wire [15:0] ALUREG;
    wire [1:0] FLG;

    // Instantiate the ALU module
    ALU uut (
        .FLGON(FLGON),
        .EN(EN),
        .OP(OP),
        .D1(D1),
        .D2(D2),
        .ALUREG(ALUREG),
        .FLG(FLG)
    );

    // Test procedure
    initial begin
        // Initialize signals
        FLGON = 0;
        EN = 1;
        OP = 3'b000;
        D1 = 16'd10;
        D2 = 16'd5;

        // Apply some test cases with different OP codes

        // Test case 1: ALU Add operation (D1 + D2)
        $display("Test 1: ADD (D1 + D2)");
        OP = 3'b000;  // Addition
        D1 = 16'd10;  // Operand 1 = 10
        D2 = 16'd5;   // Operand 2 = 5
        #10;
        $display("ALUREG = %d, FLG = %b", ALUREG, FLG);

        // Test case 2: ALU Subtract operation (D1 - D2)
        $display("Test 2: SUB (D1 - D2)");
        OP = 3'b001;  // Subtraction
        D1 = 16'd10;  // Operand 1 = 10
        D2 = 16'd5;   // Operand 2 = 5
        #10;
        $display("ALUREG = %d, FLG = %b", ALUREG, FLG);

        // Test case 3: ALU AND operation (D1 & D2)
        $display("Test 3: AND (D1 & D2)");
        OP = 3'b010;  // AND
        D1 = 16'b1100110011001100;
        D2 = 16'b1010101010101010;
        #10;
        $display("ALUREG = %b, FLG = %b", ALUREG, FLG);

        // Test case 4: ALU OR operation (D1 | D2)
        $display("Test 4: OR (D1 | D2)");
        OP = 3'b011;  // OR
        D1 = 16'b1100110011001100;
        D2 = 16'b1010101010101010;
        #10;
        $display("ALUREG = %b, FLG = %b", ALUREG, FLG);

        // Test case 5: ALU NOT operation (~D1)
        $display("Test 5: NOT (~D1)");
        OP = 3'b100;  // NOT
        D1 = 16'b1010101010101010;  // Example value for NOT
        #10;
        $display("ALUREG = %b, FLG = %b", ALUREG, FLG);

        // Test case 6: ALU with flags on for subtraction (FLGON = 1)
        $display("Test 6: SUB (D1 - D2) with FLGON = 1");
        FLGON = 1;
        OP = 3'b001;  // Subtraction
        D1 = 16'd5;   // Operand 1 = 5
        D2 = 16'd10;  // Operand 2 = 10
        #10;
        $display("ALUREG = %d, FLG = %b", ALUREG, FLG);

        // Test case 7: ALU with zero result to check Zero Flag (FLG[1])
        $display("Test 7: Zero result (D1 = D2)");
        OP = 3'b001;  // Subtraction
        D1 = 16'd7;
        D2 = 16'd7;   // D1 - D2 = 0
        #10;
        $display("ALUREG = %d, FLG = %b", ALUREG, FLG);

        // Test case 8: ALU with negative result to check Negative Flag (FLG[0])
        $display("Test 8: Negative result (D1 < D2)");
        OP = 3'b001;  // Subtraction
        D1 = 16'd5;
        D2 = 16'd10;  // D1 - D2 = -5 (check FLG[0] for negative)
        #10;
        $display("ALUREG = %d, FLG = %b", ALUREG, FLG);

        // End of test
        $finish;
    end

endmodule

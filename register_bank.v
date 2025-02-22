`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2024 23:08:24
// Design Name: 
// Module Name: register_bank
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


module register_bank(
    input [15:0] Din,
    input [15:0] ALU_IN,
    input [3:0] sel_ip,
    input [3:0] sel_op,
    input TRNSFR,clk,rst,en_pc,incpc,rstpc,ALUEN,
    output [15:0] Dout,D1_OP,D2_OP, PC_OP, IR_OP,
    output [13:0] ADDR
    );
wire PC_W,AR_W,ALUREG_W,ALUREG_W1,IR_W,D1_W,D2_W,R0_W,R1_W,R2_W,R3_W,R4_W,R5_W,R6_W,R7_W,DR_W,RES2_W;
wire [15:0] PC_IP3,PC_IP2,PC_IP1,PC_IP,AR_IP,AR_OP,ALUREG_IP,ALUREG_IP1,ALUREG_OP,IR_IP,D1_IP,D2_IP, R0_IP, R0_OP, R1_IP, R1_OP, R2_IP, R2_OP, R3_IP, R3_OP, R4_IP, R4_OP, R5_IP, R5_OP, R6_IP, R6_OP, R7_IP, R7_OP, DR_IP, DR_OP, RES2_IP, RES2_OP;
wire [15:0] ip,INC_OP;
wire [15:0] dummy1,dummy2;
decoder4to16 writer(.Din(sel_ip),.Dout({RES2_W, DR_W, R7_W, R6_W, R5_W, R4_W, R3_W, R2_W, R1_W, R0_W, D2_W, D1_W, IR_W, ALUREG_W1, AR_W, PC_W}));
mux_16x1 #(.L(2),.sel_L(1),.word_L(16)) TR (.Din({Din,Dout}),.sel(TRNSFR),.Dout(ip));
demux_1x16 ipman(.Din(ip),.sel(sel_ip),.Dout({PC_IP, AR_IP, ALUREG_IP1, IR_IP, D1_IP, D2_IP, R0_IP, R1_IP, R2_IP, R3_IP, R4_IP, R5_IP, R6_IP, R7_IP, DR_IP, RES2_IP}));
mux_16x1 opman(.Din({PC_OP, AR_OP, ALUREG_OP, IR_OP, D1_OP, D2_OP, R0_OP, R1_OP, R2_OP, R3_OP, R4_OP, R5_OP, R6_OP, R7_OP, DR_OP, RES2_OP}),.sel(sel_op),.Dout(Dout));
assign ALUREG_W = ALUREG_W1 || ALUEN;
register16bit PC(.W(PC_W), .clk(clk), .rst(rst), .Din(PC_IP3), .Dout(PC_OP));
register16bit AR(.W(AR_W), .clk(clk),. rst(rst), .Din(AR_IP), .Dout(AR_OP));
register16bit ALUREG(.W(ALUREG_W),.clk(clk),.rst(rst),.Din(ALU_IN),.Dout(ALUREG_OP));
register16bit IR(.W(IR_W), .clk(clk), .rst(rst), .Din(IR_IP), .Dout(IR_OP));
register16bit D1(.W(D1_W), .clk(clk), .rst(rst), .Din(D1_IP), .Dout(D1_OP));
register16bit D2(.W(D2_W), .clk(clk), .rst(rst), .Din(D2_IP), .Dout(D2_OP));
register16bit R0(.W(R0_W), .clk(clk), .rst(rst), .Din(R0_IP), .Dout(R0_OP));
register16bit R1(.W(R1_W), .clk(clk), .rst(rst), .Din(R1_IP), .Dout(R1_OP));
register16bit R2(.W(R2_W), .clk(clk), .rst(rst), .Din(R2_IP), .Dout(R2_OP));
register16bit R3(.W(R3_W), .clk(clk), .rst(rst), .Din(R3_IP), .Dout(R3_OP));
register16bit R4(.W(R4_W), .clk(clk), .rst(rst), .Din(R4_IP), .Dout(R4_OP));
register16bit R5(.W(R5_W), .clk(clk), .rst(rst), .Din(R5_IP), .Dout(R5_OP));
register16bit R6(.W(R6_W), .clk(clk), .rst(rst), .Din(R6_IP), .Dout(R6_OP));
register16bit R7(.W(R7_W), .clk(clk), .rst(rst), .Din(R7_IP), .Dout(R7_OP));
register16bit DR(.W(DR_W), .clk(clk), .rst(rst), .Din(DR_IP), .Dout(DR_OP));
register16bit RES2(.W(RES2_W), .clk(clk), .rst(rst), .Din(RES2_IP), .Dout(RES2_OP));
incrementor INC(.Din(PC_OP),.Dout(INC_OP));
assign ADDR = AR_OP[12:0];
mux_16x1 #(.L(2),.sel_L(1),.word_L(16)) PCSEL (.Din({PC_IP,INC_OP}),.sel(incpc),.Dout(PC_IP1));
mux_16x1 #(.L(2),.sel_L(1),.word_L(16)) PCSEL2 (.Din({PC_OP,PC_IP1}),.sel(en_pc),.Dout(PC_IP2));
mux_16x1 #(.L(2),.sel_L(1),.word_L(16)) PCSEL3 (.Din({PC_IP2,16'b0000000000000000}),.sel(rstpc),.Dout(PC_IP3));
endmodule

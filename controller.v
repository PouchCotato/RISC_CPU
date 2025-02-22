`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2024 20:12:09
// Design Name: 
// Module Name: controller
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


module controller(
    input [15:0] INSTR,
    input clk, rst,
    input [1:0] FLG,
    input [15:0] CROM_OUT,
    output [3:0] ip_reg,op_reg,
    output reg [7:0] CAR,
    output[15:0] dir_out, 
    output TRNSFR_OP,FLGON_OP,ALUEN,FLGRES,MEMWRITE,MEMREAD,enpc,rstpc,direct,incpc,
    output [2:0] ALUOP
    );
    // ADD transfer from R1 to AR when flag check is true
    wire [3:0] R1,R2,R3;
    wire gr,gre,eq,les,le,neq,res1;
    assign eq = FLG[1];
    assign les = FLG[0];
    assign neq = ~FLG[1];
    assign gr = (~FLG[0]&&~FLG[1]);
    assign gre = ~FLG[0];
    assign le = FLG[0]||FLG[1];
    mux FLGCHKER (.S(INSTR[11:9]),.D0(0),.D1(les),.D2(eq),.D3(le),.D4(gr),.D5(neq),.D6(gre),.D7(0),.out(res));
    assign R1 = INSTR[8:6] + 6;
    assign R2 = INSTR[5:3] + 6;
    assign R3 = INSTR[2:0] + 6;
    wire clk1;
    reg [3:0] trnsfr_to,trnsfr_from;
    assign clk1 = ~clk;  
    wire INCPC,TRNSFR,FLGCHK,DPC,RSTPC,FLGON,ALUADD,ALUOR,ALUNOT,ALUSUB,MEMRD,MEMWR,MVI,T3,T4,T5,temp1,temp2;
    wire [7:0] CROM_ADDR;
    assign res1 = res&&FLGCHK;   
    decoder4to16 op(.Din(CROM_OUT[15:12]),.Dout({T4, T3, MVI, MEMWR, MEMRD, ALUSUB, ALUNOT, ALUAND, ALUOR, ALUADD, FLGON, RSTPC, DPC, FLGCHK, TRNSFR, INCPC}));
    assign direct = MVI;
    assign dir_out = {7'b0000000,INSTR[11:9],INSTR[5:0]};
    assign incpc = INCPC||res1;
    assign TRNSFR_OP = TRNSFR;
    assign FLGON_OP = FLGON;
    assign ALUEN = ALUADD||ALUOR||ALUNOT||ALUSUB||FLGON;
    encoder #(.op_L(3)) ALUENC(.Din({ALUNOT, ALUOR, ALUAND, ALUSUB, ALUADD}),.Dout(ALUOP));
    assign MEMWRITE = MEMWR;
    assign MEMREAD = MEMRD;
    assign rstpc = RSTPC;
    always @(posedge clk1) begin
        if (rst) CAR <= 8'b00000000;
        else begin
            if (CROM_OUT[3] == 1) CAR <= {INSTR[15:12],4'b0000};
            else if (CROM_OUT[2] == 1) CAR <= 8'b00000000; //FETCH SEQUENCE ADDRESS
            else CAR <= CAR+8'b00000001;
        end
    end
    always @(*) begin
        if (CROM_OUT[1] == 1)
        begin
            case (CROM_OUT[11:8])
            4'b0111 : trnsfr_to <= R1;
            4'b1010 : trnsfr_to <= R2;
            4'b1101 : trnsfr_to <= R3;
            endcase 
        end
        else trnsfr_to <= CROM_OUT[11:8];
        if (CROM_OUT[0] == 1)
            begin
            case (CROM_OUT[7:4])
            4'b0111 : trnsfr_from <= R1;
            4'b1010 : trnsfr_from <= R2;
            4'b1101 : trnsfr_from <= R3;
            endcase 
        end
        else trnsfr_from <= CROM_OUT[7:4];
    end
    mux_16x1 #(.L(8),.sel_L(3),.word_L(4)) ip_reg_sel(.Din({4'b0000,trnsfr_to,4'b0000,4'b0000,R1,R1,R1,R1}),.Dout(ip_reg),.sel({MVI,INCPC,TRNSFR||MEMRD}));
    mux_16x1 #(.L(2),.sel_L(1),.word_L(4)) op_reg_sel(.Din({4'b0110,trnsfr_from}),.Dout(op_reg),.sel(TRNSFR||MEMWR));
    assign enpc = (~DPC)&&((INCPC||res1)||(TRNSFR)||(MEMRD));

endmodule

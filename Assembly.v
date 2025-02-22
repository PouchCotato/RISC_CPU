`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2024 16:55:03
// Design Name: 
// Module Name: Assembly
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


module Assembly(input rst_CPU,clk,output l1,l2,l3,l4);

    wire [15:0] MEM_Dout, REG_Dout, ALU_ALUREG, CROM_rd_data;
    wire [15:0] ALU_D1, ALU_D2, PC_OP,IR_OP,dir_out,Din;
    wire [1:0] ALU_FLG, CTRL_FLG;
    wire [3:0] CTRL_ip_reg, CTRL_op_reg;
    wire [2:0] CTRL_ALUOP;
    wire [12:0] MEM_write_addr, MEM_read_addr, REG_ADDR;
    wire [7:0] CTRL_CAR;
    wire CTRL_TRNSFR_OP, CTRL_FLGON_OP, CTRL_ALUEN, CTRL_FLGRES;
    wire CTRL_MEMWRITE, CTRL_MEMREAD, CTRL_enpc, CTRL_rstpc,CTRL_incpc;
    wire MEM_wr_done, MEM_rd_done,direct;
    mux_16x1 #(.L(2),.sel_L(1),.word_L(16)) Dat_select(.Din({MEM_Dout,dir_out}),.Dout(Din),.sel(direct));
    controller CTRL (
        .INSTR(IR_OP),
        .clk(clk),
        .rst(rst_CPU),
        .FLG(ALU_FLG),
        .CROM_OUT(CROM_rd_data),
        .ip_reg(CTRL_ip_reg),
        .op_reg(CTRL_op_reg),
        .incpc(CTRL_incpc),
        .CAR(CTRL_CAR),
        .TRNSFR_OP(CTRL_TRNSFR_OP),
        .FLGON_OP(CTRL_FLGON_OP),
        .ALUEN(CTRL_ALUEN),
        .FLGRES(CTRL_FLGRES),
        .MEMWRITE(CTRL_MEMWRITE),
        .MEMREAD(CTRL_MEMREAD),
        .enpc(CTRL_enpc),
        .rstpc(CTRL_rstpc),
        .ALUOP(CTRL_ALUOP),
        .direct(direct),
        .dir_out(dir_out)
    );

    register_bank REG (
        .IR_OP(IR_OP),
        .Din(Din),
        .sel_ip(CTRL_ip_reg),
        .sel_op(CTRL_op_reg),
        .TRNSFR(CTRL_TRNSFR_OP),
        .clk(clk),
        .rst(rst_CPU),
        .en_pc(CTRL_enpc),
        .incpc(CTRL_incpc),
        .rstpc(CTRL_rstpc),
        .Dout(REG_Dout),
        .ADDR(REG_ADDR),
        .ALUEN(CTRL_ALUEN),
        .ALU_IN(ALU_ALUREG),
        .PC_OP(PC_OP),
        .D1_OP(ALU_D1),
        .D2_OP(ALU_D2)
    );

    CROM chrome (
        .rst(rst_CPU),
        .read(1'b1), // Always reading from CROM
        .read_addr(CTRL_CAR),
        .rd_data(CROM_rd_data)
    );

    mem8k MEM (
        .clk(clk),
        .read(CTRL_MEMREAD),
        .write(CTRL_MEMWRITE),
        .rst(rst_CPU),
        .wr_data(REG_Dout),
        .write_addr(REG_ADDR),
        .read_addr(REG_ADDR),
        .rd_data(MEM_Dout),
        .wr_done(MEM_wr_done),
        .rd_done(MEM_rd_done),
        .o1(l1),.o2(l2),.o3(l3),.o4(l4)
    );

    // ALU module
    ALU alu (
        .FLGON(CTRL_FLGON_OP),
        .EN(CTRL_ALUEN),
        .OP(CTRL_ALUOP),
        .D1(ALU_D1),
        .D2(ALU_D2),
        .ALUREG(ALU_ALUREG),
        .FLG(ALU_FLG)
    );
    
    
endmodule
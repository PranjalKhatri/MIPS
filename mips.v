module mips(clk, reset);
//main cpu module

input clk;
input reset;

wire [5:0] OpCode;
wire [5:0] funct;

wire [1:0] ALUOp;

wire RegDst;
wire ALUSrc;
wire MemToReg;
wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire Jump;
wire Jal;
wire Jr;

datapath Datapath(clk,reset,RegDst,ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp,OpCode,funct,Jump,Jal,Jr);

control Control(OpCode,funct,RegDst,ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch,ALUOp,Jump,Jal,Jr); 

endmodule

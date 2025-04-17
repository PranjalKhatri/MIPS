module datapath(clk, reset, RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp,OpCode,Jump,Jal);

input clk;
input reset;

input RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Jump,Jal;

wire [31:0] Instruction;

input [1:0] ALUOp;
wire [3:0] ALUCtrl;
wire [31:0] ALUout;
wire Zero;

output [5:0] OpCode;
assign OpCode = Instruction[31:26];

wire [31:0] PC_adr;

wire [31:0] ReadRegister1;
wire [31:0] ReadRegister2;

wire [4:0] muxinstr_out;
wire [31:0] muxalu_out;
wire [31:0] muxdata_out;

wire [31:0] ReadData;

wire [31:0] signExtend,jSignExtend;
wire [31:0] muxSignExtend;

wire PCsel;

mem_async meminstr(PC_adr[7:0],Instruction); //Instruction memory
mem_sync memdata(clk, ALUout[7:0], ReadData, ReadRegister2, MemRead, MemWrite); //Data memory
rf registerfile(clk,RegWrite,Instruction[25:21],Instruction[20:16],muxinstr_out, ReadRegister1, ReadRegister2, muxdata_out); //Registers
//---------------------------rs----------------rt
alucontrol AluControl(ALUOp, Instruction[5:0], ALUCtrl); //ALUControl-----inst[5:0] - > funct
alu Alu(ReadRegister1, muxalu_out, ALUCtrl, ALUout, Zero); //ALU

andm andPC(Branch, Zero, PCsel); //AndPC (branch & zero)
signextend Signextend(signExtend, Instruction[15:0]); //Sign extend

Jumpsignextend jumpSignExtend(jSignExtend, Instruction[25:0]); //Sign extend

mux #(5) muxinstr(RegDst, Instruction[20:16],Instruction[15:11],muxinstr_out);//MUX for Write Register----here comes rt and rd
//--use rd for read instruction
mux #(32) muxalu(AluSrc, ReadRegister2, muxSignExtend, muxalu_out);//MUX for ALU
mux #(32) muxdata(MemtoReg, ALUout, ReadData, muxdata_out); //MUX for Data memory
mux #(32) muxSE(Jump,signExtend,jSignExtend,muxSignExtend);

pclogic PC(clk, reset, muxSignExtend, PC_adr, PCsel); //generate PC
always @(*)begin
    $display("pc is %d",PC_adr);
end

endmodule

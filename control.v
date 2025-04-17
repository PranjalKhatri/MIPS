module control(opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal);

input [5:0] opcode;

output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;
output reg Jump;
output reg Jal;
output reg [1:0] AluOP;

always @(opcode) begin
	case (opcode)
		6'b000000:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal}=11'b100100_0_10_0_0; //r
		6'b100011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal}=11'b011110_0_00_0_0; //lw
		6'b101011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal}=11'bx1x001_0_00_0_0; //sw
		6'b000100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal}=11'bx0x000_1_01_0_0; //beq
		6'b000011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal}=11'bxxx100_1_00_1_1; //jal
		6'b000010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal}=11'bxxx000_1_00_1_0; // j

		default:
	{RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,AluOP,Jump,Jal}=9'bxxx_xxx_x_xx_x_x;
	endcase
	if(Jump)
		$display("jump enables");
end

endmodule

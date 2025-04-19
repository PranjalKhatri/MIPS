module control(opcode,funct, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr);

input [5:0] opcode;
input [5:0] funct;

output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg Branch;
output reg Jump;
output reg Jal;
output reg Jr;
output reg [1:0] AluOP;

always @(opcode or funct) begin
	case (opcode)
		6'b000000:begin
			case (funct)
				6'b001000: 
					{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr}=12'b000000_0_00_1_0_1; //r
				default: 
					{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr}=12'b100100_0_10_0_0_0; //r
			endcase
		end
		6'b100011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr}=12'b011110_0_00_0_0_0; //lw
		6'b101011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr}=12'bx1x001_0_00_0_0_0; //sw
		6'b000100:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr}=12'bx0x000_1_01_0_0_0; //beq
		6'b000011:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr}=12'b1xx100_0_00_1_1_0; //jal
		6'b000010:{RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOP,Jump,Jal,Jr}=12'bxxx000_0_00_1_0_0; // j

		default:
	{RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,AluOP,Jump,Jal,Jr}=12'bxxx_xxx_x_xx_x_x_x;
	endcase
	$display("opcode %b funct %b",opcode,funct);
	if(Jump)
		$display("jump enables");

end

endmodule

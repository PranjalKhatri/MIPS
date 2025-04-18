module pclogic(clk, reset, ain, aout, pcsel,jmp);

input reset;
input clk;
input [31:0] ain;
//pecsel = branch & zero
input pcsel;
input jmp;
output reg [31:0] aout;

always @(posedge clk ) begin
	if (reset==1)
		aout<=32'b0;
	else begin
		if(jmp ===1)begin
			aout = {aout[31:26],ain[25:0]};
		end 
		else begin
			if (pcsel==0) begin
				aout<=aout+1;
			end
			if (pcsel==1) begin
				aout<=ain+aout+1; //branch
				$display("a branch at pc of ain %d",ain);
			end
		end
	end
end


endmodule

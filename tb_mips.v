module tb_mips;
//cpu testbench

reg clk;
reg res;

mips mips_DUT(clk, res);

initial
	forever #5 clk = ~clk;
integer i;
initial begin
	clk = 0;
	res = 1;
	#10 res = 0;

	#3000
	for (i = 0; i < mips_DUT.Datapath.memdata.L;i++ ) begin
		$display("memory content at %d is %d",i,mips_DUT.Datapath.memdata.memory[i]);
	end
	$finish;

end

endmodule

`timescale 1ns/1ps
`define DATAWIDTH 32

module TB_First_Fill();

reg  clk;
reg  rst_n;
reg  tready;
wire tvalid;
wire tdata;
wire Debug_Din_Valid;
wire Debug_Sel_Valid;
wire Debug_Resize;
wire [7:0] m_axis_tdata;
wire oStart;

First_Fill_IP_wrapper TB(  
	.clk(clk),
	.rst_n(rst_n),
	.tready(tready),
	.tvalid(tvalid),
	.tdata(tdata),
	.Debug_Din_Valid(Debug_Din_Valid),
	.Debug_Sel_Valid(Debug_Sel_Valid),
	.Debug_Resize(Debug_Resize),
	.m_axis_tdata(m_axis_tdata),
	.oStart(oStart)
);

integer fileoutput0,fileoutput1;

initial
begin
	$display("Running TestBench");
	fileoutput0 = $fopen("C:/Users/Howard/Desktop/First_Fill/Sim_Files/Sim_Resize.txt");
	fileoutput1 = $fopen("C:/Users/Howard/Desktop/First_Fill/Sim_Files/Sim_First_Fill.txt");
	clk    = 0;
	rst_n  = 0;
	tready = 0;
	#20 rst_n  = 1;
	#20 tready = 1;
end

always #5 clk = ~clk; 

always @ (posedge clk) begin
	if(Debug_Din_Valid) begin
		$fwrite(fileoutput0,"%b\n",Debug_Resize);
	end
end

always @(posedge clk) begin
	if(tvalid)begin
		$fwrite(fileoutput1,"%b\n",tdata);
	end
end

always @(posedge clk) begin
	if($realtime > 10300) begin
		$fclose(fileoutput0);
	end
end

always @(posedge clk) begin
	if($realtime > 11630) begin
		$display("End");
		$fclose(fileoutput1);
		$stop;
	end
end

endmodule
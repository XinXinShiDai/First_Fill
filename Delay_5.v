module Delay_5(
	input  aclk,
	input  aresetn,
	input  iStart,
	output oStart
);

reg [4:0] Start_Delay; 

always @(posedge aclk or negedge aresetn) begin
    if(!aresetn) begin
        Start_Delay <= 0;
    end
    else begin
        Start_Delay[0] <= iStart;
        Start_Delay[1] <= Start_Delay[0];
        Start_Delay[2] <= Start_Delay[1];
        Start_Delay[3] <= Start_Delay[2];
        Start_Delay[4] <= Start_Delay[3];
    end
end

assign oStart = Start_Delay[4];

endmodule
`include "./pattern/PATTERN_Iota.v"
`include "./src/Iota.v"
module TESTBED_Iota();




wire clk;
wire [63:0]in_data;
wire [4:0]in_round;
wire [63:0]out_data;

Iota U_Iota
(
	.clk(clk),
	.in_data(in_data),
	.in_round(in_round),
	.out_data(out_data)
);


PATTERN_Iota U_PATTERN_Iota
(
	.clk(clk),
	.in_data(in_data),
	.in_round(in_round),
	.out_data(out_data)
);

integer i;
initial begin
	$dumpfile("./vcd/Iota.vcd"); // Name your VCD file
    	$dumpvars(0, TESTBED_Iota); // Dump signals starting at time 0
end

endmodule

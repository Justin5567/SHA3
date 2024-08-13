//############################################################################
//
//   Author      : Po-Wei Huang
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : TESTBED_SHA3.v
//   Module Name : TESTBED_SHA3
//   Release version : v1.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################
`timescale 1ns/10ps

`include "./pattern/PATTERN_SHA3_v3.v"
`include "./src/SHA3_v2.v"
	  		  	
module TESTBED_SHA3_v3;

wire clk, rst_n, in_valid, out_valid;
wire [63:0] in_data;
wire [63:0] out_data;
wire in_isLast;
wire out_buffer_full;

integer i;
initial begin
	$dumpfile("./vcd/SHA3_v3.vcd"); // Name your VCD file
    	$dumpvars(0, TESTBED_SHA3_v3); // Dump signals starting at time 0
for(i=0;i<25;i=i+1)begin
		
		$dumpvars(0, U_PATTERN_SHA3_v3.out_data_reg[i]);	
		$dumpvars(0, U_SHA3_v2.data_reg[i]);	
end
for(i=0;i<17;i=i+1)begin
		$dumpvars(0, U_PATTERN_SHA3_v3.in_data_reg[i]);
end

end


SHA3_v2 U_SHA3_v2(
    // Input signals
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .in_isLast(in_isLast),
    // Output signals
    .out_valid(out_valid),
    .out_data(out_data),
    .out_buffer_full(out_buffer_full)
);
	
PATTERN_SHA3_v3 U_PATTERN_SHA3_v3(
    // Input signals
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .in_isLast(in_isLast),
    // Output signals
    .out_valid(out_valid),
    .out_data(out_data),
    .out_buffer_full(out_buffer_full)
);
  
endmodule

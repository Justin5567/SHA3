//############################################################################
//
//   Author      : Po-Wei Huang
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : TESTBED_wrapper_v4.v
//   Module Name : TESTBED_wrapper_v4
//   Release version : v1.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################
`timescale 1ns/10ps

`include "./pattern/PATTERN_wrapper_v4.v"
`include "./src/wrapper_v4.v"
	  		  	
module TESTBED_wrapper_v4;

wire clk, rst_n, in_valid, out_valid, in_ready, out_ready, in_done;
wire [63:0] in_data;
wire [63:0] out_data;


integer i;
initial begin
	$dumpfile("./vcd/wrapper_v4.vcd"); // Name your VCD file
    	$dumpvars(0, TESTBED_wrapper_v4); // Dump signals starting at time 0
    	for(i=0;i<25;i=i+1)begin
		//$dumpvars(0, U_PATTERN_wrapper.in_data_reg[i]);
		//$dumpvars(0, U_PATTERN_wrapper.out_data_reg[i]);	
		$dumpvars(0, U_wrapper_v4.u_SHA3_v2.data_reg[i]);	
	end
	for(i=0;i<4;i=i+1)begin
		$dumpvars(0, U_wrapper_v4.out_data_reg[i]);	
	end
end


wrapper_v4 U_wrapper_v4(
    // Input signals
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_ready(out_ready),
    .in_done(in_done),
    // Output signals
    .out_valid(out_valid),
    .out_data(out_data),
    .in_ready(in_ready)

);
	
PATTERN_wrapper_v4 U_PATTERN_wrapper_v4(
    // Input signals
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_ready(out_ready),
    .in_done(in_done),
    // Output signals
    .out_valid(out_valid),
    .out_data(out_data),
    .in_ready(in_ready)

);
  
endmodule

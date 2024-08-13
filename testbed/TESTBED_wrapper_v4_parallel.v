//############################################################################
//
//   Author      : Po-Wei Huang
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : TESTBED_wrapper_v4_parallel.v
//   Module Name : TESTBED_wrapper_v4_parallel
//   Release version : v4.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################
`timescale 1ns/10ps

`include "./pattern/PATTERN_wrapper_v4_parallel.v"
`include "./src/wrapper_v4_parallel.v"
	  		  	
module TESTBED_wrapper_v4_parallel;

wire clk, rst_n, in_valid, out_valid, in_ready, out_ready, in_done;
wire [63:0] in_data_0;
wire [63:0] in_data_1;
wire [63:0] in_data_2;
wire [63:0] in_data_3;
wire [63:0] in_data_4;
wire [63:0] in_data_5;
wire [63:0] in_data_6;
wire [63:0] in_data_7;
wire [63:0] in_data_8;
wire [63:0] in_data_9;
wire [63:0] in_data_10;
wire [63:0] in_data_11;
wire [63:0] in_data_12;
wire [63:0] in_data_13;
wire [63:0] in_data_14;
wire [63:0] in_data_15;
wire [63:0] in_data_16;
wire [63:0] out_data_0;
wire [63:0] out_data_1;
wire [63:0] out_data_2;
wire [63:0] out_data_3;



integer i;
initial begin
	$dumpfile("./vcd/wrapper_v4_parallel.vcd"); // Name your VCD file
    	$dumpvars(0, TESTBED_wrapper_v4_parallel); // Dump signals starting at time 0
    	for(i=0;i<25;i=i+1)begin
		$dumpvars(0, U_wrapper_v4_parallel.u_SHA3_v3.data_reg[i]);	
	end
	for(i=0;i<4;i=i+1)begin
		$dumpvars(0, U_wrapper_v4_parallel.out_data_reg[i]);	
	end
end


wrapper_v4_parallel U_wrapper_v4_parallel(
    // Input signals
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data_0(in_data_0),
    .in_data_1(in_data_1),
    .in_data_2(in_data_2),
    .in_data_3(in_data_3),
    .in_data_4(in_data_4),
    .in_data_5(in_data_5),
    .in_data_6(in_data_6),
    .in_data_7(in_data_7),
    .in_data_8(in_data_8),
    .in_data_9(in_data_9),
    .in_data_10(in_data_10),
    .in_data_11(in_data_11),
    .in_data_12(in_data_12),
    .in_data_13(in_data_13),
    .in_data_14(in_data_14),
    .in_data_15(in_data_15),
    .in_data_16(in_data_16),
    .out_ready(out_ready),
    .in_done(in_done),
    // Output signals
    .out_valid(out_valid),
    .out_data_0(out_data_0),
    .out_data_1(out_data_1),
    .out_data_2(out_data_2),
    .out_data_3(out_data_3),
    .in_ready(in_ready)
);
	
PATTERN_wrapper_v4_parallel U_PATTERN_wrapper_v4_parallel(
    // Input signals
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data_0(in_data_0),
    .in_data_1(in_data_1),
    .in_data_2(in_data_2),
    .in_data_3(in_data_3),
    .in_data_4(in_data_4),
    .in_data_5(in_data_5),
    .in_data_6(in_data_6),
    .in_data_7(in_data_7),
    .in_data_8(in_data_8),
    .in_data_9(in_data_9),
    .in_data_10(in_data_10),
    .in_data_11(in_data_11),
    .in_data_12(in_data_12),
    .in_data_13(in_data_13),
    .in_data_14(in_data_14),
    .in_data_15(in_data_15),
    .in_data_16(in_data_16),
    .out_ready(out_ready),
    .in_done(in_done),
    // Output signals
    .out_valid(out_valid),
    .out_data_0(out_data_0),
    .out_data_1(out_data_1),
    .out_data_2(out_data_2),
    .out_data_3(out_data_3),
    .in_ready(in_ready)
);
  
endmodule

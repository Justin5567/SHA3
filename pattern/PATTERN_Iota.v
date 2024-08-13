//############################################################################
//
//   Author      : Po-Wei Huang
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : PATTERN_Iota.v
//   Module Name : PATTERN_Iota
//   Release version : v1.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`timescale 1ns/10ps
`define CYCLE_TIME 10
`define End_CYCLE  100000000

module PATTERN_Iota(
	clk,
	in_data,
	in_round,
	out_data
);

// ===============================================================
// Input & Output Declaration
// ===============================================================
output reg clk;
output reg [63:0] in_data;
output reg [4:0] in_round;
input out_valid;
input [63:0] out_data;

// ===============================================================
// Parameters & Integer Declaration
// ===============================================================
integer golden_read;
integer patcount,output_count;
integer gap;
integer a;
integer i, j;
parameter PATNUM = 70; // change after
// ===============================================================
// Wire & Reg Declaration
// ===============================================================
reg [1599:0] in_data_all_reg;
reg [63:0] in_data_reg[0:24];
reg [4:0] in_round_reg;
reg [1599:0] out_data_all_reg;
reg [63:0] out_data_reg[0:24];
wire [63:0] test;
assign test = out_data_all_reg[63:0];



// ===============================================================
// Clock
// ===============================================================
always	#(`CYCLE_TIME/2.0) clk = ~clk;
initial	clk = 0;

// ===============================================================
// Initial
// ===============================================================
initial begin
	
	golden_read  = $fopen("./testcase/iota_tb.txt","r");
	@(negedge clk);

	//a = $fscanf(golden_read, "%d", PATNUM);
	for (patcount=0;patcount<PATNUM;patcount=patcount+1) begin		
		load_golden;
		input_task;
		check_answer;
		@(negedge clk);
	end
	#(1000);
	$display("Pass");
	$finish;
end 

// ===============================================================
// TASK
// ===============================================================


task load_golden; begin
	a = $fscanf(golden_read, "%d\n", in_round_reg );
	a = $fscanf(golden_read, "%h\n", in_data_all_reg );
	a = $fscanf(golden_read, "%h\n", out_data_all_reg);

	
end endtask
 
task input_task;begin
	@(negedge clk);
	in_data = in_data_reg[0];
	in_round = in_round_reg;
end endtask

task check_answer;begin
	#(10);
	if(out_data!==out_data_reg[0])begin
		$display ("----------------------------------------------------------------------");
		$display ("  FAIL %2d\n                						                     ",patcount);
		$display ("  Oops! Your Answer is Wrong                						     ");
 		$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[0]);
 		$display ("  [Your Answer] %h\n                 						         ",out_data);
 		$display ("--------------------------------------------------------------------- ");
 		$finish;
 	end
 	else begin
 		$display("\033[1;32mPass \033[1;0mNo. %2d\n",patcount);
 		$display ("  [Your Answer] %h\n                 						         ",out_data);
 		$display ("----------------------------------------------------------------------");
 	end
end endtask




always@(*)begin
	in_data_reg[24] =  in_data_all_reg[64*0 +63:64*0 +0];
	in_data_reg[23] =  in_data_all_reg[64*1 +63:64*1 +0];
	in_data_reg[22] =  in_data_all_reg[64*2 +63:64*2 +0];
	in_data_reg[21] =  in_data_all_reg[64*3 +63:64*3 +0];
	in_data_reg[20] =  in_data_all_reg[64*4 +63:64*4 +0];
	in_data_reg[19] =  in_data_all_reg[64*5 +63:64*5 +0];
	in_data_reg[18] =  in_data_all_reg[64*6 +63:64*6 +0];
	in_data_reg[17] =  in_data_all_reg[64*7 +63:64*7 +0];
	in_data_reg[16] =  in_data_all_reg[64*8 +63:64*8 +0];
	in_data_reg[15] =  in_data_all_reg[64*9 +63:64*9 +0];
	in_data_reg[14] = in_data_all_reg[64*10+63:64*10+0];
	in_data_reg[13] = in_data_all_reg[64*11+63:64*11+0];
	in_data_reg[12] = in_data_all_reg[64*12+63:64*12+0];
	in_data_reg[11] = in_data_all_reg[64*13+63:64*13+0];
	in_data_reg[10] = in_data_all_reg[64*14+63:64*14+0];
	in_data_reg[9 ] = in_data_all_reg[64*15+63:64*15+0];
	in_data_reg[8 ] = in_data_all_reg[64*16+63:64*16+0];
	in_data_reg[7 ] = in_data_all_reg[64*17+63:64*17+0];
	in_data_reg[6 ] = in_data_all_reg[64*18+63:64*18+0];
	in_data_reg[5 ] = in_data_all_reg[64*19+63:64*19+0];
	in_data_reg[4 ] = in_data_all_reg[64*20+63:64*20+0];
	in_data_reg[3 ] = in_data_all_reg[64*21+63:64*21+0];
	in_data_reg[2 ] = in_data_all_reg[64*22+63:64*22+0];
	in_data_reg[1 ] = in_data_all_reg[64*23+63:64*23+0];
	in_data_reg[0 ] = in_data_all_reg[64*24+63:64*24+0];

	out_data_reg[24] =  out_data_all_reg[64*0 +63:64*0 +0];
	out_data_reg[23] =  out_data_all_reg[64*1 +63:64*1 +0];
	out_data_reg[22] =  out_data_all_reg[64*2 +63:64*2 +0];
	out_data_reg[21] =  out_data_all_reg[64*3 +63:64*3 +0];
	out_data_reg[20] =  out_data_all_reg[64*4 +63:64*4 +0];
	out_data_reg[19] =  out_data_all_reg[64*5 +63:64*5 +0];
	out_data_reg[18] =  out_data_all_reg[64*6 +63:64*6 +0];
	out_data_reg[17] =  out_data_all_reg[64*7 +63:64*7 +0];
	out_data_reg[16] =  out_data_all_reg[64*8 +63:64*8 +0];
	out_data_reg[15] =  out_data_all_reg[64*9 +63:64*9 +0];
	out_data_reg[14] = out_data_all_reg[64*10+63:64*10+0];
	out_data_reg[13] = out_data_all_reg[64*11+63:64*11+0];
	out_data_reg[12] = out_data_all_reg[64*12+63:64*12+0];
	out_data_reg[11] = out_data_all_reg[64*13+63:64*13+0];
	out_data_reg[10] = out_data_all_reg[64*14+63:64*14+0];
	out_data_reg[9 ] = out_data_all_reg[64*15+63:64*15+0];
	out_data_reg[8 ] = out_data_all_reg[64*16+63:64*16+0];
	out_data_reg[7 ] = out_data_all_reg[64*17+63:64*17+0];
	out_data_reg[6 ] = out_data_all_reg[64*18+63:64*18+0];
	out_data_reg[5 ] = out_data_all_reg[64*19+63:64*19+0];
	out_data_reg[4 ] = out_data_all_reg[64*20+63:64*20+0];
	out_data_reg[3 ] = out_data_all_reg[64*21+63:64*21+0];
	out_data_reg[2 ] = out_data_all_reg[64*22+63:64*22+0];
	out_data_reg[1 ] = out_data_all_reg[64*23+63:64*23+0];
	out_data_reg[0 ] = out_data_all_reg[64*24+63:64*24+0];
end
endmodule

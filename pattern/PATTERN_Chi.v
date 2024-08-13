
//############################################################################
//
//   Author      : Po-Wei Huang
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : pattern_Chi.v
//   Module Name : PATTERN_Chi
//   Release version : v2.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`timescale 1ns/10ps
`define CYCLE_TIME 10
`define End_CYCLE  100000000

module PATTERN_Chi(
//output
 in_data_0,
 in_data_1,
 in_data_2,
 in_data_3,
 in_data_4,
 in_data_5,
 in_data_6,
 in_data_7,
 in_data_8,
 in_data_9,
 in_data_10,
 in_data_11,
 in_data_12,
 in_data_13,
 in_data_14,
 in_data_15,
 in_data_16,
 in_data_17,
 in_data_18,
 in_data_19,
 in_data_20,
 in_data_21,
 in_data_22,
 in_data_23,
 in_data_24,
 //input
 out_data_0,
 out_data_1,
 out_data_2,
 out_data_3,
 out_data_4,
 out_data_5,
 out_data_6,
 out_data_7,
 out_data_8,
 out_data_9,
 out_data_10,
 out_data_11,
 out_data_12,
 out_data_13,
 out_data_14,
 out_data_15,
 out_data_16,
 out_data_17,
 out_data_18,
 out_data_19,
 out_data_20,
 out_data_21,
 out_data_22,
 out_data_23,
 out_data_24,
);

// ===============================================================
// Input & Output Declaration
// ===============================================================
//input
output reg [63:0] in_data_0;
output reg [63:0] in_data_1;
output reg [63:0] in_data_2;
output reg [63:0] in_data_3;
output reg [63:0] in_data_4;
output reg [63:0] in_data_5;
output reg [63:0] in_data_6;
output reg [63:0] in_data_7;
output reg [63:0] in_data_8;
output reg [63:0] in_data_9;
output reg [63:0] in_data_10;
output reg [63:0] in_data_11;
output reg [63:0] in_data_12;
output reg [63:0] in_data_13;
output reg [63:0] in_data_14;
output reg [63:0] in_data_15;
output reg [63:0] in_data_16;
output reg [63:0] in_data_17;
output reg [63:0] in_data_18;
output reg [63:0] in_data_19;
output reg [63:0] in_data_20;
output reg [63:0] in_data_21;
output reg [63:0] in_data_22;
output reg [63:0] in_data_23;
output reg [63:0] in_data_24;
//output
input [63:0] out_data_0;
input [63:0] out_data_1;
input [63:0] out_data_2;
input [63:0] out_data_3;
input [63:0] out_data_4;
input [63:0] out_data_5;
input [63:0] out_data_6;
input [63:0] out_data_7;
input [63:0] out_data_8;
input [63:0] out_data_9;
input [63:0] out_data_10;
input [63:0] out_data_11;
input [63:0] out_data_12;
input [63:0] out_data_13;
input [63:0] out_data_14;
input [63:0] out_data_15;
input [63:0] out_data_16;
input [63:0] out_data_17;
input [63:0] out_data_18;
input [63:0] out_data_19;
input [63:0] out_data_20;
input [63:0] out_data_21;
input [63:0] out_data_22;
input [63:0] out_data_23;
input [63:0] out_data_24;


// ===============================================================
// Parameters & Integer Declaration
// ===============================================================
integer golden_read;
integer patcount,output_count;
integer gap;
integer a;
integer i, j;
parameter PATNUM = 15; // change after
// ===============================================================
// Wire & Reg Declaration
// ===============================================================
reg clk;
reg [1599:0] in_data_all_reg;
reg [63:0] in_data_reg[0:24];
reg [1599:0] out_data_all_reg;
reg [63:0] out_data_reg[0:24];

// ===============================================================
// Clock
// ===============================================================
always	#(`CYCLE_TIME/2.0) clk = ~clk;
initial	clk = 0;

// ===============================================================
// Initial
// ===============================================================
initial begin
	golden_read  = $fopen("./testcase/chi_tb.txt","r");
	@(negedge clk);
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
	a = $fscanf(golden_read, "%h\n", in_data_all_reg );
	a = $fscanf(golden_read, "%h\n", out_data_all_reg);
end endtask
 
task input_task;begin
 @(negedge clk);
 in_data_0 = in_data_reg[0]; 
 in_data_1 = in_data_reg[1];
 in_data_2 = in_data_reg[2];
 in_data_3 = in_data_reg[3];
 in_data_4 = in_data_reg[4];
 in_data_5 = in_data_reg[5];
 in_data_6 = in_data_reg[6];
 in_data_7 = in_data_reg[7];
 in_data_8 = in_data_reg[8];
 in_data_9 = in_data_reg[9];
 in_data_10= in_data_reg[10];
 in_data_11= in_data_reg[11];
 in_data_12= in_data_reg[12];
 in_data_13= in_data_reg[13];
 in_data_14= in_data_reg[14];
 in_data_15= in_data_reg[15];
 in_data_16= in_data_reg[16];
 in_data_17= in_data_reg[17];
 in_data_18= in_data_reg[18];
 in_data_19= in_data_reg[19];
 in_data_20= in_data_reg[20];
 in_data_21= in_data_reg[21];
 in_data_22= in_data_reg[22];
 in_data_23= in_data_reg[23];
 in_data_24= in_data_reg[24];
end endtask

task check_answer;begin
#(10);
		// check answer
		//0
 		if(out_data_0!==out_data_reg[0])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 00 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[0]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_0);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
		//1
 		if(out_data_1!==out_data_reg[1])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 01 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[1]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_1);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//2
 		if(out_data_2!==out_data_reg[2])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 02 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[2]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_2);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
 	
//3
 		if(out_data_3!==out_data_reg[3])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 03 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[3]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_3);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//4
 		if(out_data_4!==out_data_reg[4])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 04 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[4]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_4);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
 
//5
 		if(out_data_5!==out_data_reg[5])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 05 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[5]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_5);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//6
 		if(out_data_6!==out_data_reg[6])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 6 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[6]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_6);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//7
 		if(out_data_7!==out_data_reg[7])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 7 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[7]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_7);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//8
 		if(out_data_8!==out_data_reg[8])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 8 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[8]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_8);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//9
 		if(out_data_9!==out_data_reg[9])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 9 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[9]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_9);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//10
 		if(out_data_10!==out_data_reg[10])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 10 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[10]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_10);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//11
 		if(out_data_11!==out_data_reg[11])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 11 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[11]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_11);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//12
 		if(out_data_12!==out_data_reg[12])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 12 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[12]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_12);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//13
 		if(out_data_13!==out_data_reg[13])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 13 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[13]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_13);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//14
 		if(out_data_14!==out_data_reg[14])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 14 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[14]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_14);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//15
 		if(out_data_15!==out_data_reg[15])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 15 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[15]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_15);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
 //16
 		if(out_data_16!==out_data_reg[16])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 16 block                						     \n");
 			$display ("  [Correct Answer] %h\n               					             ",out_data_reg[16]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_16);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//17
 		if(out_data_17!==out_data_reg[17])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 17 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[17]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_17);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//18
 		if(out_data_18!==out_data_reg[18])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 18 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[18]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_18);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//19
 		if(out_data_19!==out_data_reg[19])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 19 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[19]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_19);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
 //20
 		if(out_data_20!==out_data_reg[20])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 20 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[20]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_20);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//21
 		if(out_data_21!==out_data_reg[21])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 21 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[21]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_21);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//22
 		if(out_data_22!==out_data_reg[22])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 22 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[22]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_22);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//23
 		if(out_data_23!==out_data_reg[23])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 23 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[23]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_23);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end
//24
 		if(out_data_24!==out_data_reg[24])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in 24 block                						     \n");
 			$display ("  [Correct Answer] %h\n                 					             ",out_data_reg[24]);
 			$display ("  [Your Answer] %h\n                 						         ",out_data_24);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end



end endtask




always@(*)begin
	in_data_reg[24] =  in_data_all_reg[64*0 +63:64*0 +0];
	in_data_reg[19] =  in_data_all_reg[64*1 +63:64*1 +0];
	in_data_reg[14] =  in_data_all_reg[64*2 +63:64*2 +0];
	in_data_reg[9 ] =  in_data_all_reg[64*3 +63:64*3 +0];
	in_data_reg[4 ] =  in_data_all_reg[64*4 +63:64*4 +0];
	in_data_reg[23] =  in_data_all_reg[64*5 +63:64*5 +0];
	in_data_reg[18] =  in_data_all_reg[64*6 +63:64*6 +0];
	in_data_reg[13] =  in_data_all_reg[64*7 +63:64*7 +0];
	in_data_reg[8 ] =  in_data_all_reg[64*8 +63:64*8 +0];
	in_data_reg[3 ] =  in_data_all_reg[64*9 +63:64*9 +0];
	in_data_reg[22] =  in_data_all_reg[64*10+63:64*10+0];
	in_data_reg[17] =  in_data_all_reg[64*11+63:64*11+0];
	in_data_reg[12] =  in_data_all_reg[64*12+63:64*12+0];
	in_data_reg[7 ] =  in_data_all_reg[64*13+63:64*13+0];
	in_data_reg[2 ] =  in_data_all_reg[64*14+63:64*14+0];
	in_data_reg[21] =  in_data_all_reg[64*15+63:64*15+0];
	in_data_reg[16] =  in_data_all_reg[64*16+63:64*16+0];
	in_data_reg[11] =  in_data_all_reg[64*17+63:64*17+0];
	in_data_reg[6 ] =  in_data_all_reg[64*18+63:64*18+0];
	in_data_reg[1 ] =  in_data_all_reg[64*19+63:64*19+0];
	in_data_reg[20] =  in_data_all_reg[64*20+63:64*20+0];
	in_data_reg[15] =  in_data_all_reg[64*21+63:64*21+0];
	in_data_reg[10] =  in_data_all_reg[64*22+63:64*22+0];
	in_data_reg[5 ] =  in_data_all_reg[64*23+63:64*23+0];
	in_data_reg[0 ] =  in_data_all_reg[64*24+63:64*24+0];

	out_data_reg[24] =  out_data_all_reg[64*0 +63:64*0 +0];
	out_data_reg[19] =  out_data_all_reg[64*1 +63:64*1 +0];
	out_data_reg[14] =  out_data_all_reg[64*2 +63:64*2 +0];
	out_data_reg[9 ] =  out_data_all_reg[64*3 +63:64*3 +0];
	out_data_reg[4 ] =  out_data_all_reg[64*4 +63:64*4 +0];
	out_data_reg[23] =  out_data_all_reg[64*5 +63:64*5 +0];
	out_data_reg[18] =  out_data_all_reg[64*6 +63:64*6 +0];
	out_data_reg[13] =  out_data_all_reg[64*7 +63:64*7 +0];
	out_data_reg[8 ] =  out_data_all_reg[64*8 +63:64*8 +0];
	out_data_reg[3 ] =  out_data_all_reg[64*9 +63:64*9 +0];
	out_data_reg[22] =  out_data_all_reg[64*10+63:64*10+0];
	out_data_reg[17] =  out_data_all_reg[64*11+63:64*11+0];
	out_data_reg[12] =  out_data_all_reg[64*12+63:64*12+0];
	out_data_reg[7 ] =  out_data_all_reg[64*13+63:64*13+0];
	out_data_reg[2 ] =  out_data_all_reg[64*14+63:64*14+0];
	out_data_reg[21] =  out_data_all_reg[64*15+63:64*15+0];
	out_data_reg[16] =  out_data_all_reg[64*16+63:64*16+0];
	out_data_reg[11] =  out_data_all_reg[64*17+63:64*17+0];
	out_data_reg[6 ] =  out_data_all_reg[64*18+63:64*18+0];
	out_data_reg[1 ] =  out_data_all_reg[64*19+63:64*19+0];
	out_data_reg[20] =  out_data_all_reg[64*20+63:64*20+0];
	out_data_reg[15] =  out_data_all_reg[64*21+63:64*21+0];
	out_data_reg[10] =  out_data_all_reg[64*22+63:64*22+0];
	out_data_reg[5 ] =  out_data_all_reg[64*23+63:64*23+0];
	out_data_reg[0 ] =  out_data_all_reg[64*24+63:64*24+0];
end
endmodule

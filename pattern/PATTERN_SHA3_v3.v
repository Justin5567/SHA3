//############################################################################
//
//   Author      : Po-Wei Huang
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : PATTERN_SHA3.v
//   Module Name : PATTERN_SHA3
//   Release version : v2.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`timescale 1ns/10ps
`define CYCLE_TIME 10
`define End_CYCLE  100000000

module PATTERN_SHA3_v3(
	clk,
	rst_n,
	in_valid,
	in_data,
	in_isLast,
	out_valid,
	out_data,
	out_buffer_full
);

// ===============================================================
// Input & Output Declaration
// ===============================================================
output reg clk, rst_n, in_valid;
output reg [63:0] in_data;
output reg in_isLast;
input out_valid;
input [63:0] out_data;
input out_buffer_full;

// ===============================================================
// Parameters & Integer Declaration
// ===============================================================
integer golden_read;
integer patcount,output_count;
integer gap;
integer a;
integer i, j;
parameter PATNUM = 7; // change after
// ===============================================================
// Wire & Reg Declaration
// ===============================================================
reg [1599:0] in_data_all_reg;
reg [63:0] in_data_reg[0:16];
reg in_isLast_reg;
reg [1599:0] out_data_all_reg;
reg [63:0] out_data_reg[0:24];
reg out_buffer_full_reg;

reg read_done;


// ===============================================================
// Clock
// ===============================================================
always	#(`CYCLE_TIME/2.0) clk = ~clk;
initial	clk = 0;

// ===============================================================
// Initial
// ===============================================================
initial begin
	rst_n    = 1'b1;
	in_valid = 1'b0;
	in_isLast = 1'b0;
	

	force clk = 0;
	reset_task;
	$display("Reset Complete");
	golden_read  = $fopen("./testcase/sha3_tb_v2.txt","r");
	
	@(negedge clk);

	for (patcount=0;patcount<PATNUM;patcount=patcount+1) begin	
		$display("\n------------------------------------------------------\n\033[1;44m[Start Pattern] %02d\033[1;0m", patcount);	
		read_done = 0;
		$display("\033[1;33m[Input Data] \033[1;0m");
		while(read_done==0)begin
			load_golden;
			input_task;
			if(in_isLast==0)begin
				while(out_buffer_full)begin
					@(negedge clk);
				end
			end
			
			gap = $urandom_range(2,4);
			repeat(gap) @(negedge clk);
		end
		$display();
		check_answer;
		@(negedge clk);
	end
	#(1000);
	$display("\033[1;32m\033[5m[Pass] Congradulation You Have Pass All of the TestCases\033[0;0m");
	$finish;
end 

// ===============================================================
// TASK
// ===============================================================
task reset_task ; begin
	#(20); rst_n = 0;
	#(20);
	if((out_valid !== 0) || (out_data !== 0) || (out_buffer_full!==0)) begin
		$display ("--------------------------------------------------------------------------------------------------------------------------------------------");
		$display ("                                                                        FAIL!                                                               ");
		$display ("                                                  Output signal should be 0 after initial RESET at %8t                                      ",$time);
		$display ("--------------------------------------------------------------------------------------------------------------------------------------------");
		#(100);
	    $finish ;
	end
	#(20); rst_n = 1 ;
	#(6.0); release clk;
end endtask

reg [63:0] curr_in_reg;
reg [7:0] reg1;
reg [7:0] reg2;
reg [7:0] reg3;
reg [7:0] reg4;
reg [7:0] reg5;
reg [7:0] reg6;
reg [7:0] reg7;
reg [7:0] reg8;
integer t;
integer t2;
integer round_t;
reg [9:0] len_reg;
task load_golden; begin
	a = $fscanf(golden_read, "%d\n", in_isLast_reg);
	a = $fscanf(golden_read, "%d\n", len_reg);
	if(in_isLast_reg==1)begin
		read_done = 1;
	end	
	t=0;
	in_data_all_reg = 0;
	round_t = 0;
	for(i=0;i<17;i=i+1)begin
		in_data_reg[i] = 0;
	end
	
	while(t!=len_reg)begin
		t2 = len_reg-t;
		if(t2>=8)begin
			a = $fscanf(golden_read, "%c", reg1);
			a = $fscanf(golden_read, "%c", reg2);
			a = $fscanf(golden_read, "%c", reg3);
			a = $fscanf(golden_read, "%c", reg4);
			a = $fscanf(golden_read, "%c", reg5);
			a = $fscanf(golden_read, "%c", reg6);
			a = $fscanf(golden_read, "%c", reg7);
			a = $fscanf(golden_read, "%c", reg8);
			t=t+8;
			$write("%s%s%s%s%s%s%s%s",reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8);
		end
		else begin
			case(t2)
				1:begin
					a = $fscanf(golden_read, "%c", reg1);
					reg2=0;
					reg3=0;
					reg4=0;
					reg5=0;
					reg6=0;
					reg7=0;
					reg8=0;
					t=t+1;
					$write("%s",reg1);
				end
				2:begin
					a = $fscanf(golden_read, "%c", reg1);
					a = $fscanf(golden_read, "%c", reg2);
					reg3=0;
					reg4=0;
					reg5=0;
					reg6=0;
					reg7=0;
					reg8=0;
					t=t+2;
					$write("%s%s",reg1,reg2);
				end
				3:begin
					a = $fscanf(golden_read, "%c", reg1);
					a = $fscanf(golden_read, "%c", reg2);
					a = $fscanf(golden_read, "%c", reg3);
					reg4=0;
					reg5=0;
					reg6=0;
					reg7=0;
					reg8=0;
					t=t+3;
					$write("%s%s%s",reg1,reg2,reg3);
				end
				4:begin
					a = $fscanf(golden_read, "%c", reg1);
					a = $fscanf(golden_read, "%c", reg2);
					a = $fscanf(golden_read, "%c", reg3);
					a = $fscanf(golden_read, "%c", reg4);
					reg5=0;
					reg6=0;
					reg7=0;
					reg8=0;
					t=t+4;
					$write("%s%s%s%s",reg1,reg2,reg3,reg4);
				end 
				5:begin
					a = $fscanf(golden_read, "%c", reg1);
					a = $fscanf(golden_read, "%c", reg2);
					a = $fscanf(golden_read, "%c", reg3);
					a = $fscanf(golden_read, "%c", reg4);
					a = $fscanf(golden_read, "%c", reg5);
					reg6=0;
					reg7=0;
					reg8=0;
					t=t+5;
					$write("%s%s%s%s%s",reg1,reg2,reg3,reg4,reg5);
				end
				6: begin
					a = $fscanf(golden_read, "%c", reg1);
					a = $fscanf(golden_read, "%c", reg2);
					a = $fscanf(golden_read, "%c", reg3);
					a = $fscanf(golden_read, "%c", reg4);
					a = $fscanf(golden_read, "%c", reg5);
					a = $fscanf(golden_read, "%c", reg6);
					reg7=0;
					reg8=0;
					t=t+6;
					$write("%s%s%s%s%s%s",reg1,reg2,reg3,reg4,reg5,reg6);
				end
				7:begin
					a = $fscanf(golden_read, "%c", reg1);
					a = $fscanf(golden_read, "%c", reg2);
					a = $fscanf(golden_read, "%c", reg3);
					a = $fscanf(golden_read, "%c", reg4);
					a = $fscanf(golden_read, "%c", reg5);
					a = $fscanf(golden_read, "%c", reg6);
					a = $fscanf(golden_read, "%c", reg7);
					reg8=0;
					t=t+7;
					$write("%s%s%s%s%s%s%s",reg1,reg2,reg3,reg4,reg5,reg6,reg7);
				end
			endcase
		end
		
		curr_in_reg={reg8,reg7,reg6,reg5,reg4,reg3,reg2,reg1};
		case(round_t)
			0: in_data_reg[0] = curr_in_reg;
			1: in_data_reg[1] = curr_in_reg;   
			2: in_data_reg[2] = curr_in_reg;
			3: in_data_reg[3] = curr_in_reg;
			4: in_data_reg[4] = curr_in_reg;
			5: in_data_reg[5] = curr_in_reg;
			6: in_data_reg[6] = curr_in_reg;
			7: in_data_reg[7] = curr_in_reg;
			8: in_data_reg[8] = curr_in_reg;
			9: in_data_reg[9] = curr_in_reg;
			10:in_data_reg[10]= curr_in_reg;
			11:in_data_reg[11]= curr_in_reg;
			12:in_data_reg[12]= curr_in_reg;
			13:in_data_reg[13]= curr_in_reg;
			14:in_data_reg[14]= curr_in_reg;
			15:in_data_reg[15]= curr_in_reg;
			16:in_data_reg[16]= curr_in_reg;
		endcase
		round_t = round_t+1;
	end
	if(read_done)begin
		a = $fscanf(golden_read, "%h\n", out_data_all_reg);
	end
end endtask

integer tmp;

task input_task;begin
	@(negedge clk);
	in_valid = 1'b1;
	in_isLast = 0 ;
	for(i=0;i<17;i=i+1)begin
		tmp = len_reg/8;
		if(i==((len_reg-1)/8))begin
			in_isLast = in_isLast_reg;
		end
		in_data = in_data_reg[i];
		@(negedge clk);
		in_valid = 0;
		if(in_isLast)begin
			@(negedge clk);
			in_valid = 0;
			i=18;
		end
		else begin
			gap = $urandom_range(2,4);
			repeat(gap) @(negedge clk);
			in_valid = 1'b1;
		end
		
	end

	//@(negedge clk);
	in_valid = 1'b0;
	in_data = 'bx;
end endtask

reg [255:0]tmp_ans;

task check_answer;begin
	// wait out_valid raise
	while(out_valid==0)begin
		@(negedge clk);
	end
	output_count = 0;
	tmp_ans = 256'h0;
	while(out_valid==1)begin
		// check answer
 		if(out_data!==out_data_reg[output_count])begin
 			$display ("----------------------------------------------------------------------");
 			$display ("  FAIL %2d\n                						                     ",patcount);
 			$display ("  Oops! Your Answer is Wrong in %d block                						     \n",output_count);
 			$display ("  [Correct DATA] %h\n                 					             ",out_data_reg[output_count]);
 			$display ("  [Your DATA] %h\n                 						         ",out_data);
 			$display ("--------------------------------------------------------------------- ");
 			$finish;
 		end

 		else begin
 			//$display("\033[1;32mPass \033[1;0mNo. %2d-%2d\n",patcount,output_count);
 			//$display ("  [Your Data] %h\n                 						         ",out_data);
 			//$display ("----------------------------------------------------------------------");
			tmp_ans ={tmp_ans[191:0], out_data[7:0],out_data[15:8],out_data[23:16],out_data[31:24],out_data[39:32],out_data[47:40],out_data[55:48],out_data[63:56]};
 		end
		output_count = output_count+1;
		@(negedge clk);
	end
	$display ("\033[1;33m[Calculate Hash]\033[1;0m\n%h                 						         ",tmp_ans);
	$display("\033[1;32m[Pass No.%02d] \033[1;0m", patcount);


end endtask






always@(*)begin
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


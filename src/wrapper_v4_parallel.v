`include "./src/SHA3_v3.v"

module wrapper_v4_parallel
(
 clk,
 rst_n,
 in_ready,
 in_valid,
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
 in_done,
 out_ready,
 out_valid,
 out_data_0,
 out_data_1,
 out_data_2,
 out_data_3,
 busy
);

// ===============================================================
// Input & Output Declaration
// ===============================================================
input 			clk;
input 			rst_n;
input 			in_valid;
input			out_ready;
input 	[63:0]  	in_data_0;
input 	[63:0]  	in_data_1;
input 	[63:0]  	in_data_2;
input 	[63:0]  	in_data_3;
input 	[63:0]  	in_data_4;
input 	[63:0]  	in_data_5;
input 	[63:0]  	in_data_6;
input 	[63:0]  	in_data_7;
input 	[63:0]  	in_data_8;
input 	[63:0]  	in_data_9;
input 	[63:0]  	in_data_10;
input 	[63:0]  	in_data_11;
input 	[63:0]  	in_data_12;
input 	[63:0]  	in_data_13;
input 	[63:0]  	in_data_14;
input 	[63:0]  	in_data_15;
input 	[63:0]  	in_data_16;
input 			in_done;
output	reg		in_ready;
output 	reg		out_valid;
output 	reg [63:0]	out_data_0;
output 	reg [63:0]	out_data_1;
output 	reg [63:0]	out_data_2;
output 	reg [63:0]	out_data_3;
output 			busy;
// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i;

localparam IDLE 	= 4'd0;
localparam RD		= 4'd1;
localparam RD_WAIT	= 4'd2;
localparam IDLE2	= 4'd3;
localparam SHA3_INPUT 	= 4'd4;
localparam SHA3_WAIT  	= 4'd5;
localparam SHA3_DONE 	= 4'd6;
localparam IDLE3	= 4'd7;
localparam DONE		= 4'd8;
localparam DONE_WAIT	= 4'd9;

//================================================================
// Wire & Reg Declaration
//================================================================

reg [3:0] state_cs,state_ns;

reg [63:0] data_reg;
reg [63:0] out_data_reg[0:3];
reg in_done_reg;
reg [4:0]counter;
//sha3 signal
reg [63:0] 	sha3_in_data;
reg 		sha3_in_valid;
reg 		sha3_in_isLast;
wire 		sha3_out_valid;
wire [63:0]	sha3_out_data;
wire 		sha3_out_buffer_full;

// in module buffer
reg [63:0] buffer_sram [0:16];
reg buffer_sram_full;
//================================================================
// SUB MODULE
//================================================================
SHA3_v3 u_SHA3_v3(
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(sha3_in_valid),
	.in_data(sha3_in_data),
	.in_isLast(sha3_in_isLast),
	.out_valid(sha3_out_valid),
	.out_data(sha3_out_data),
	.out_buffer_full(sha3_out_buffer_full)
);

always@(*)begin
	if(state_ns==SHA3_INPUT)
		sha3_in_valid = 1;
	else 
		sha3_in_valid = 0;
end

always@(*)begin
	if(state_ns==SHA3_INPUT)
		sha3_in_data = buffer_sram[counter];
	else
		sha3_in_data = 0;	
end

//assign sha3_in_isLast = in_done;
always@(*)begin
	if(state_ns==SHA3_INPUT)
		sha3_in_isLast = in_done_reg;
	else
		sha3_in_isLast = 0;
end
//================================================================
// DESIGN
//================================================================

assign busy = state_cs!=IDLE;
//FSM 
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		state_cs<=IDLE;
	else
		state_cs<=state_ns;
end

always@(*)begin
	case(state_cs)
		IDLE:		state_ns = (in_valid)? RD : IDLE;
		RD:		state_ns = IDLE2;
		RD_WAIT:	state_ns = (in_valid)? RD : RD_WAIT;
		IDLE2:		state_ns = (!sha3_out_buffer_full)? SHA3_INPUT : IDLE2;
		SHA3_INPUT:	state_ns =  (counter==17)? SHA3_WAIT : SHA3_INPUT; //serial input data from buffer_sram to sha3 register 
		SHA3_WAIT:	begin
					if((!sha3_out_buffer_full && !in_done_reg) || (!buffer_sram_full && !in_done_reg))
						state_ns = RD_WAIT;
					else if(sha3_out_valid)
						state_ns = SHA3_DONE;
					else 
						state_ns = SHA3_WAIT;
				end
		SHA3_DONE:	state_ns = (!sha3_out_valid)? IDLE3: SHA3_DONE; //obtain all output data save in out_data_reg[0] ~ out_data_reg[3]
		IDLE3:		state_ns = DONE_WAIT;
		DONE:		state_ns = IDLE;
		DONE_WAIT:	state_ns = (out_ready)? DONE: DONE_WAIT; 
		default:	state_ns = state_cs;
	endcase
end

//counter
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		counter<=0;
	else if(state_ns==IDLE || state_ns==IDLE3 || state_ns==IDLE2 || state_ns==SHA3_WAIT)
		counter<=0;
	else if(state_ns==SHA3_INPUT || state_ns==RD || state_ns==SHA3_DONE || state_ns==DONE)
		counter<=counter+1;
end

// in_done_reg
// cant ensure in_done be active forever using register to keep it while in_valid
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		in_done_reg<=0;
	end
	else if(state_ns==IDLE)
		in_done_reg<=0;
	else if(state_ns==RD)
		in_done_reg<=in_done;
end

always@(*)begin
	if(state_cs==DONE || state_cs==DONE_WAIT)
		out_valid = 1;
	else 
		out_valid = 0;
end

// in_ready
always@(*)begin
	if(state_cs==IDLE || state_cs==RD_WAIT)
		in_ready = 1;
	else
		in_ready = 0;

end

// buffer_sram
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		for(i=0;i<17;i=i+1)begin
			buffer_sram[i]<=0;
		end
	end
	else if(state_ns==IDLE || state_ns==SHA3_WAIT)begin
		for(i=0;i<17;i=i+1)begin
			buffer_sram[i]<=0;
		end
	end
	else if(state_ns==RD) begin
		buffer_sram[0] <= in_data_0;
		buffer_sram[1] <= in_data_1;
		buffer_sram[2] <= in_data_2;
		buffer_sram[3] <= in_data_3;
		buffer_sram[4] <= in_data_4;
		buffer_sram[5] <= in_data_5;
		buffer_sram[6] <= in_data_6;
		buffer_sram[7] <= in_data_7;
		buffer_sram[8] <= in_data_8;
		buffer_sram[9] <= in_data_9;
		buffer_sram[10] <= in_data_10;
		buffer_sram[11] <= in_data_11;
		buffer_sram[12] <= in_data_12;
		buffer_sram[13] <= in_data_13;
		buffer_sram[14] <= in_data_14;
		buffer_sram[15] <= in_data_15;
		buffer_sram[16] <= in_data_16;
	end
end
// buffer_sram_full
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		buffer_sram_full<=0;
	else if(state_ns==IDLE)
		buffer_sram_full<=0;
	else if(state_ns==SHA3_INPUT)
		buffer_sram_full<=0;
	else if(state_cs==SHA3_WAIT && state_ns==RD_WAIT)
		buffer_sram_full<=1;
end

// out_data_reg
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		for(i=0;i<4;i=i+1)begin
			out_data_reg[i]<=0;
		end
	end
	else if(state_ns==IDLE)begin
		for(i=0;i<4;i=i+1)begin
			out_data_reg[i]<=0;
		end
	end
	else if(state_ns==SHA3_DONE)begin
		out_data_reg[counter]<=sha3_out_data;
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		out_data_0<=0;
		out_data_1<=0;
		out_data_2<=0;
		out_data_3<=0;
	end
	else if(state_ns==IDLE)begin
		out_data_0<=0;
		out_data_1<=0;
		out_data_2<=0;
		out_data_3<=0;
	end
	else if(state_ns==DONE || state_ns==DONE_WAIT)begin
		out_data_0<=out_data_reg[0];
		out_data_1<=out_data_reg[1];
		out_data_2<=out_data_reg[2];
		out_data_3<=out_data_reg[3];
	end

end

endmodule


`include "./pattern/PATTERN_Chi.v"
`include "./src/Chi.v"
module TESTBED_Chi();

wire [63:0]in_data_0;
wire [63:0]in_data_1;
wire [63:0]in_data_2;
wire [63:0]in_data_3;
wire [63:0]in_data_4;
wire [63:0]in_data_5;
wire [63:0]in_data_6;
wire [63:0]in_data_7;
wire [63:0]in_data_8;
wire [63:0]in_data_9;
wire [63:0]in_data_10;
wire [63:0]in_data_11;
wire [63:0]in_data_12;
wire [63:0]in_data_13;
wire [63:0]in_data_14;
wire [63:0]in_data_15;
wire [63:0]in_data_16;
wire [63:0]in_data_17;
wire [63:0]in_data_18;
wire [63:0]in_data_19;
wire [63:0]in_data_20;
wire [63:0]in_data_21;
wire [63:0]in_data_22;
wire [63:0]in_data_23;
wire [63:0]in_data_24;

wire [63:0]out_data_0;
wire [63:0]out_data_1;
wire [63:0]out_data_2;
wire [63:0]out_data_3;
wire [63:0]out_data_4;
wire [63:0]out_data_5;
wire [63:0]out_data_6;
wire [63:0]out_data_7;
wire [63:0]out_data_8;
wire [63:0]out_data_9;
wire [63:0]out_data_10;
wire [63:0]out_data_11;
wire [63:0]out_data_12;
wire [63:0]out_data_13;
wire [63:0]out_data_14;
wire [63:0]out_data_15;
wire [63:0]out_data_16;
wire [63:0]out_data_17;
wire [63:0]out_data_18;
wire [63:0]out_data_19;
wire [63:0]out_data_20;
wire [63:0]out_data_21;
wire [63:0]out_data_22;
wire [63:0]out_data_23;
wire [63:0]out_data_24;

Chi U_Chi
(
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
	.in_data_17(in_data_17),
	.in_data_18(in_data_18),
	.in_data_19(in_data_19),
	.in_data_20(in_data_20),
	.in_data_21(in_data_21),
	.in_data_22(in_data_22),
	.in_data_23(in_data_23),
	.in_data_24(in_data_24),
	.out_data_0(out_data_0),
	.out_data_1(out_data_1),
	.out_data_2(out_data_2),
	.out_data_3(out_data_3),
	.out_data_4(out_data_4),
	.out_data_5(out_data_5),
	.out_data_6(out_data_6),
	.out_data_7(out_data_7),
	.out_data_8(out_data_8),
	.out_data_9(out_data_9),
	.out_data_10(out_data_10),
	.out_data_11(out_data_11),
	.out_data_12(out_data_12),
	.out_data_13(out_data_13),
	.out_data_14(out_data_14),
	.out_data_15(out_data_15),
	.out_data_16(out_data_16),
	.out_data_17(out_data_17),
	.out_data_18(out_data_18),
	.out_data_19(out_data_19),
	.out_data_20(out_data_20),
	.out_data_21(out_data_21),
	.out_data_22(out_data_22),
	.out_data_23(out_data_23),
	.out_data_24(out_data_24)
);


PATTERN_Chi U_PATTERN_Chi
(
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
	.in_data_17(in_data_17),
	.in_data_18(in_data_18),
	.in_data_19(in_data_19),
	.in_data_20(in_data_20),
	.in_data_21(in_data_21),
	.in_data_22(in_data_22),
	.in_data_23(in_data_23),
	.in_data_24(in_data_24),
	.out_data_0(out_data_0),
	.out_data_1(out_data_1),
	.out_data_2(out_data_2),
	.out_data_3(out_data_3),
	.out_data_4(out_data_4),
	.out_data_5(out_data_5),
	.out_data_6(out_data_6),
	.out_data_7(out_data_7),
	.out_data_8(out_data_8),
	.out_data_9(out_data_9),
	.out_data_10(out_data_10),
	.out_data_11(out_data_11),
	.out_data_12(out_data_12),
	.out_data_13(out_data_13),
	.out_data_14(out_data_14),
	.out_data_15(out_data_15),
	.out_data_16(out_data_16),
	.out_data_17(out_data_17),
	.out_data_18(out_data_18),
	.out_data_19(out_data_19),
	.out_data_20(out_data_20),
	.out_data_21(out_data_21),
	.out_data_22(out_data_22),
	.out_data_23(out_data_23),
	.out_data_24(out_data_24)

);

integer i;
initial begin
	$dumpfile("./vcd/Chi.vcd"); // Name your VCD file
    	$dumpvars(0, TESTBED_Chi); // Dump signals starting at time 0
end

endmodule

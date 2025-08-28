`ifndef MY_IF__SV
`define MY_IF__SV

interface sha3_if(input bit clk);

logic           rst_n;
logic           in_valid;
logic           out_ready;
logic [63:0]    in_data;
logic           in_done;
logic           in_ready;
logic           out_valid;
logic [63:0]    out_data;
logic           busy;


    modport DUT (
        input clk, rst_n,
        input  in_valid, out_ready, in_data, in_done,
        output in_ready, out_valid, out_data, busy
    );
    
    // Modport for TB (Driver, Monitor)
    modport TB (
        input clk, rst_n,
        output  in_valid, out_ready, in_data, in_done,
        input in_ready, out_valid, out_data, busy
    );

endinterface

`endif 
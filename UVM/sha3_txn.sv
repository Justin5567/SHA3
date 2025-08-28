`ifndef SHA3_TXN__SV
`define SHA3_TXN__SV

import uvm_pkg::*; 
`include "uvm_macros.svh"

class sha3_txn extends uvm_sequence_item;

    rand bit [63:0] in_data;
    rand bit        in_valid;
    rand bit        in_done;
    
    bit in_ready;
    bit out_ready;
    bit     out_valid;
    bit  [63:0] out_data;

    `uvm_object_utils(sha3_txn)

    function new(string name = "sha3_txn");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("in_data = 0x%h, in_valid = %0b, in_done = %0b => out_valid = %0b, out_data = 0x%h",
                         in_data, in_valid, in_done, out_valid, out_data);
    endfunction

endclass

`endif

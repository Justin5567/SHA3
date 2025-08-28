`ifndef SHA3_SEQ__SV
`define SHA3_SEQ__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sha3_txn.sv"

class sha3_seq extends uvm_sequence #(sha3_txn);

`uvm_object_utils(sha3_seq)

function new(string name = "sha3_sequence");
    super.new(name);
endfunction

task body();

    sha3_txn txn;

    int num_inputs;

    // num_inputs = $urandom_range(5,40);
    num_inputs = 1;
    `uvm_info(get_type_name(),$sformatf("Generating %0d input blocks",num_inputs),UVM_MEDIUM);
    for(int i=0;i<num_inputs;i++)begin
        txn = sha3_txn::type_id::create($sformatf("txn_%0d",i));
        // txn.in_data = $urandom();
        txn.in_data = 48'h6E697473754A;
        txn.in_valid = 1;
        // txn.in_done = (i==num_inputs-1);
        txn.in_done = 0;
        txn.out_ready = 1;
        `uvm_info(get_type_name(), $sformatf("[SEQ SEND] idx = %0d, in_data = 0x%016h,in_done=%0b",i,txn.in_data,txn.in_done),UVM_LOW);

        start_item(txn);
        finish_item(txn);
    end  

    txn = sha3_txn::type_id::create("txn_done");
    txn.in_valid = 0;
    txn.in_done  = 1;
    start_item(txn);
    finish_item(txn);

endtask

endclass


`endif 
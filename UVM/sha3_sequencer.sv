`ifndef SHA3_SEQUENCER__SV
`define SHA3_SEQUENCER__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sha3_txn.sv"

class sha3_sequencer extends uvm_sequencer #(sha3_txn);

    `uvm_component_utils(sha3_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass

`endif

`ifndef SHA3_TEST__SV
`define SHA3_TEST__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sha3_env.sv"
`include "sha3_sequence.sv"

class sha3_test extends uvm_test;

    `uvm_component_utils(sha3_test)

    sha3_env env;

    function new(string name = "sha3_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = sha3_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        sha3_seq seq;

        phase.raise_objection(this);
        `uvm_info(get_type_name(), ">>> RAISE OBJECTION <<<", UVM_LOW)

        seq = sha3_seq::type_id::create("seq");
        seq.start(env.sequencer);

        `uvm_info(get_type_name(), ">>> DROP OBJECTION <<<", UVM_LOW)
        phase.drop_objection(this);
    endtask

endclass



`endif

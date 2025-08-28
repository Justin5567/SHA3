`ifndef SHA3_ENV__SV
`define SHA3_ENV__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sha3_driver.sv"
`include "sha3_monitor.sv"
`include "sha3_sequencer.sv"
`include "sha3_scoreboard.sv"

class sha3_env extends uvm_env;

    `uvm_component_utils(sha3_env)

    // Sub-components
    sha3_sequencer sequencer;
    sha3_driver    driver;
    sha3_monitor   monitor;
    sha3_scoreboard scoreboard;

    // Analysis port relay
    uvm_analysis_port #(sha3_txn) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        sequencer = sha3_sequencer::type_id::create("sequencer", this);
        driver    = sha3_driver::type_id::create("driver", this);
        monitor   = sha3_monitor::type_id::create("monitor", this);
        scoreboard= sha3_scoreboard::type_id::create("scoreboard",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        driver.seq_item_port.connect(sequencer.seq_item_export);
        // monitor.ap.connect(this.ap); // propagate to test/scoreboard
        monitor.ap.connect(scoreboard.monitor_export);
        driver.drv2sb_ap.connect(scoreboard.driver_export);
    endfunction

endclass

`endif

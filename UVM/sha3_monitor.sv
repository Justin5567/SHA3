`ifndef SHA3_MONITOR__SV
`define SHA3_MONITOR__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sha3_txn.sv"
`include "sha3_if.sv"
class sha3_monitor extends uvm_monitor #(sha3_txn);
    
    `uvm_component_utils(sha3_monitor)
    virtual sha3_if.TB vif;
    uvm_analysis_port #(sha3_txn) ap;

    


    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap",this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // get virtual interface from config db
        if(!uvm_config_db #(virtual sha3_if.TB)::get(this,"","vif",vif))begin
            `uvm_fatal(get_type_name(),"Virtual interface not found: vif")
        end
    endfunction

   
    task run_phase(uvm_phase phase);
        sha3_txn txn;
        forever begin

            @(posedge vif.clk);
            if(vif.in_valid)begin
                txn = sha3_txn::type_id::create("monitor_input_txn");
                txn.in_data = vif.in_data;
                txn.in_valid = vif.in_valid;
                txn.in_done = vif.in_done;
                txn.in_ready = vif.in_ready; // <-- Capture in_ready from DUT
                `uvm_info(get_type_name(), $sformatf("[MONITOR RECV INPUT] in_data = 0x%016h, in_valid = %0b, in_done = %0b", txn.in_data, txn.in_valid, txn.in_done), UVM_LOW);
                ap.write(txn);

                `uvm_info(get_type_name,txn.convert2string(), UVM_LOW);
            end
            if(vif.out_valid && vif.out_ready) begin
                txn = sha3_txn::type_id::create("monitor_output_txn");
                txn.out_valid = vif.out_valid;
                txn.out_data  = vif.out_data;

                `uvm_info(get_type_name(), $sformatf("[MONITOR RECV OUTPUT] out_valid = %0b, out_data = 0x%016h", txn.out_valid, txn.out_data), UVM_LOW);

                // send txn back to scoreboard
                ap.write(txn);
            end
        end
    endtask


endclass
`endif 
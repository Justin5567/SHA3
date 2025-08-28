`ifndef SHA3_DRIVER__SV
`define SHA3_DRIVER__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sha3_txn.sv"

class sha3_driver extends uvm_driver #(sha3_txn);
    
    `uvm_component_utils(sha3_driver)
    virtual sha3_if.TB vif;
    uvm_analysis_port #(sha3_txn) drv2sb_ap;
    function new(string name, uvm_component parent);
        super.new(name, parent);
        drv2sb_ap = new("drv2sb_ap",this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // get virtual interface from config db
        if(!uvm_config_db #(virtual sha3_if.TB)::get(this,"","vif",vif))begin
            `uvm_fatal(get_type_name(),"Virtual interface not found: vif")
        end
    endfunction


    int gap;
    int output_count;
    task run_phase(uvm_phase phase);
        sha3_txn txn;
        output_count = 0;
        while (vif.rst_n !== 1) begin
            @(negedge vif.clk);
            vif.in_valid <= 0;
            vif.in_done  <= 0;
            vif.out_ready <= 0;
            //  `uvm_info(get_type_name(), $sformatf("[Watiting RESET] reset %d",vif.rst_n),UVM_LOW);
        end
        `uvm_info(get_type_name(), $sformatf("[RESET COMPLETE]"),UVM_LOW);
        forever begin // if there is several transactions, the loop will keep running
            seq_item_port.get_next_item(txn);
            `uvm_info(get_type_name(), $sformatf("[Enter] Driver"),UVM_LOW);
            drv2sb_ap.write(txn);
            if(txn.in_done)begin
                vif.in_valid <= 0; 
                vif.in_data  <= 0;
                vif.out_ready <= 1;
                vif.in_done <=0;
                @(negedge vif.clk);
                while(!vif.in_ready) begin
                    @(negedge vif.clk);
                end
                gap = $urandom_range(2,4); 
                repeat(gap) @(negedge vif.clk);
                vif.in_done  <= txn.in_done;
                @(negedge vif.clk);
                vif.in_valid<=0;

                while(vif.out_valid==0) begin
                    @(negedge vif.clk);
                end
                while(output_count!=4)begin // 4 outputs for 256 bits
                    `uvm_info(get_type_name(), $sformatf("[DRIVER RECV] out_data = 0x%016h, out_valid = %0b", vif.out_data, vif.out_valid),UVM_LOW);
                    output_count = output_count +1;
                    @(negedge vif.clk);
                    vif.out_ready <= 0;
                    gap = $urandom_range(2,4);
                    repeat(gap) @(negedge vif.clk);
                    vif.out_ready <= 1;
                    while(vif.out_valid==0 && output_count<4) begin 
                        @(negedge vif.clk);
                        `uvm_info(get_type_name(), $sformatf("[DRIVER WAIT] Waiting for output valid"),UVM_LOW);
                    end	
                end
            end

            else begin
                vif.in_valid <= txn.in_valid; 
                vif.in_data  <= txn.in_data;
                vif.out_ready <= txn.out_ready;
                vif.in_done <=txn.in_done;
                `uvm_info(get_type_name(), $sformatf("[DRIVER SEND] in_data = 0x%016h, in_done = %0b", txn.in_data, txn.in_done),UVM_LOW);
                @(negedge vif.clk);
                vif.in_valid<=0;
                @(negedge vif.clk);
                

            end


            seq_item_port.item_done();
            
        end
    endtask


endclass
`endif 
`ifndef SHA3_SCOREBOARD__SV
`define SHA3_SCOREBOARD__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sha3_txn.sv"
`include "sha3_dpi.svh"


class sha3_scoreboard extends uvm_component;

    `uvm_component_utils(sha3_scoreboard)
    uvm_analysis_imp #(sha3_txn, sha3_scoreboard) monitor_export;
    uvm_analysis_imp #(sha3_txn, sha3_scoreboard) driver_export;
    // uvm_analysis_port #(sha3_txn) ap;
    string input_str;

    string ref_output_hash;
    bit [63:0] input_data_q[$];
    byte golden_digest[32];

    byte golden_hash[65];  
    string input_msg;
    int input_len;
    string hash_str;

    string compute_hash;
    string part;

    int out_count;

    function new(string name, uvm_component parent);
        super.new(name,parent);
        monitor_export = new("analysis_export",this);
        driver_export = new("driver_export",this);
        // ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
    endfunction
    

    function string words64_to_string(const ref bit [63:0] q[$]);
    string s = "";
    foreach (q[i]) begin
        //   if (LITTLE_ENDIAN_BYTES) begin
        //     // bytes in order [7:0], [15:8], ... [63:56]
            for (int b = 0; b < 8; b++) begin
            byte ch = q[i][8*b +: 8];
            if (ch != 0) s = {s, ch};
            end
        //   end else begin
            // bytes in order [63:56], [55:48], ... [7:0]
            // for (int b = 7; b >= 0; b--) begin
            //   byte ch = q[i][8*b +: 8];
            //   if (ch != 0) s = {s, ch};
            // end
        //   end
        end
        return s;
    endfunction

    function automatic bit [63:0] swap_endian64(input bit [63:0] data);
        bit [63:0] res;
        for (int i = 0; i < 8; i++) begin
            res[i*8 +: 8] = data[(7-i)*8 +: 8];
        end
        return res;
    endfunction

    function void write(sha3_txn t);
        `uvm_info(get_type_name(), $sformatf("[CHECK] in_done = %0b, in_valid = %0b, in_ready = %0b", t.in_done, t.in_valid, t.in_ready), UVM_LOW);
        if(t.in_valid && t.in_ready) begin
            `uvm_info(get_type_name(), $sformatf("[Monitor] in_data = 0x%016h, in_done = %0b", t.in_data, t.in_done), UVM_LOW);
            input_data_q.push_back(t.in_data);
            input_str = $sformatf("%s%0h", input_str, t.in_data);

            for(int i=0;i<input_data_q.size();i++) begin
                `uvm_info(get_type_name(), $sformatf("input_data_q[%0d] = 0x%016h", i, input_data_q[i]), UVM_LOW);
            end
        end
        
        if(t.out_valid) begin
            `uvm_info(get_type_name(), $sformatf("[Monitor] out_data = 0x%016h",t.out_data), UVM_LOW);
            part = $sformatf("%016h", swap_endian64(t.out_data));
            compute_hash = {compute_hash, part};
            out_count++;
            // $display("[Monitor] compute_hash: %s", compute_hash);
            if(out_count==4)begin
                if(compute_hash!=hash_str)begin
                    `uvm_error(get_type_name(), $sformatf(
                        "Hash mismatch!\nInput: %s\nGolden: %s\nDUT: %s",
                        input_msg, hash_str, compute_hash
                    ));
                end else begin
                    `uvm_info(get_type_name(), $sformatf("[Monitor] Hash match passed!"), UVM_LOW);
                    `uvm_info(get_type_name(), $sformatf("[HASH] %064s", compute_hash), UVM_LOW);
                end
                
            end
        end
        
        

        if(t.in_done)begin
            out_count = 0;

            // `uvm_info(get_type_name(), $sformatf("[Monitor] in_done = %0b", t.in_done), UVM_LOW);
            input_msg = words64_to_string(input_data_q);
            input_len = input_msg.len();
            $display("[DPI] inputmsg: %s, len %d", input_msg,input_len);
            compute_sha3_dpi(input_msg, input_len, golden_hash);

            // convert byte array to string for display
            hash_str = "";
            foreach (golden_hash[i]) begin
                if (golden_hash[i] == 0) break;
                hash_str = {hash_str, golden_hash[i]};
            end

            $display("[DPI] Digest: %s", hash_str);
        end
    
        

 
        // if (golden_digest != t.output_digest) begin
        //     `uvm_error(get_type_name(), $sformatf(
        //         "Hash mismatch!\nInput: %s\nGolden: %p\nDUT: %p",
        //         t.input_msg, golden_digest, t.output_digest
        //     ));
        // end else begin
        //     `uvm_info(get_type_name(), "SHA3 hash match passed!", UVM_LOW);
        // end
    endfunction

    

endclass


`endif 
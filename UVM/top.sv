module top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "sha3_test.sv"
    `include "sha3_if.sv"
    // `include "sha3_dpi.svh"


    logic clk;
    logic rst_n;
    // sha3_if sha3_if(.*);

    sha3_if sha3_if(clk);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    // byte golden_hash[65];  
    // string input_msg;
    // int input_len;
    // string hash_str;
    // initial begin
    //     input_msg = "Justin";
    //     input_len = input_msg.len();

    //     compute_sha3_dpi(input_msg, input_len, golden_hash);

    //     // convert byte array to string for display
    //     hash_str = "";
    //     foreach (golden_hash[i]) begin
    //         if (golden_hash[i] == 0) break;
    //         hash_str = {hash_str, golden_hash[i]};
    //     end

    //     $display("[DPI] Digest: %s", hash_str);
    // end

    initial begin
        sha3_if.rst_n = 0;
        // remember to reset input signal
        sha3_if.in_valid = 0;
        sha3_if.in_done = 0;
        sha3_if.in_data = 0;
        sha3_if.out_ready = 0;
        repeat(10) @(posedge clk);
        sha3_if.rst_n = 1;
    end

    // DUT instance
    wrapper_v4 dut (
        .clk        (clk),
        .rst_n     (sha3_if.rst_n),
        .in_ready   (sha3_if.in_ready),
        .in_valid   (sha3_if.in_valid),
        .in_data    (sha3_if.in_data),
        .in_done    (sha3_if.in_done),
        .out_ready  (sha3_if.out_ready),
        .out_valid  (sha3_if.out_valid),
        .out_data   (sha3_if.out_data),
        .busy       (sha3_if.busy)
    );

    // Virtual Interface Binding
    initial begin
        uvm_config_db#(virtual sha3_if.TB)::set(null, "*", "vif", sha3_if);
        run_test("sha3_test");
    end

    initial begin
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars(0, dut);
    end

    // Simulation time limit
    initial begin
        int cycle_limit = 1000; 
        repeat(cycle_limit) @(posedge clk);
        $display("Reached cycle limit (%0d cycles), stopping simulation.", cycle_limit);
        $finish;
    end

endmodule

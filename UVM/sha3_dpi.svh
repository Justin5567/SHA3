import "DPI-C" context task compute_sha3_dpi(
    input string in_data,
    input int    in_len,
    output byte out_hash[65]
);


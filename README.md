# SHA3

## Introduction
This repo implements sha3 in hardware by using verilog.
I provides two input methods, serial and parallel, to accommodate different usage senarios. 


## Usage
you can simply use iverilog to simulate the results

```
$ iverilog -o ./vvp/**TESTMODULE** ./TESTBED/**TESTMODULE** -I ./
 $ vvp ./vvp/**TESTMODULE**
```

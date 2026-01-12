#!/bin/bash
# Verify dao-voting on BaseScan
forge verify-contract $ADDRESS 06-dao-voting/src/*.sol:* --chain-id 8453

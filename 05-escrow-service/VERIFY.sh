#!/bin/bash
# Verify escrow-service on BaseScan
forge verify-contract $ADDRESS 05-escrow-service/src/*.sol:* --chain-id 8453

#!/bin/bash
# Verify token-vesting on BaseScan
forge verify-contract $ADDRESS 11-token-vesting/src/*.sol:* --chain-id 8453

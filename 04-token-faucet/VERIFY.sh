#!/bin/bash
# Verify token-faucet on BaseScan
forge verify-contract $ADDRESS 04-token-faucet/src/*.sol:* --chain-id 8453

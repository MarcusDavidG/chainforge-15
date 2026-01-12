#!/bin/bash
# Verify crowdfunding on BaseScan
forge verify-contract $ADDRESS 09-crowdfunding/src/*.sol:* --chain-id 8453

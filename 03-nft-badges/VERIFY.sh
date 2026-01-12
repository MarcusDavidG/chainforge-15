#!/bin/bash
# Verify nft-badges on BaseScan
forge verify-contract $ADDRESS 03-nft-badges/src/*.sol:* --chain-id 8453

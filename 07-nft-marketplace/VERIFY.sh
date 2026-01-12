#!/bin/bash
# Verify nft-marketplace on BaseScan
forge verify-contract $ADDRESS 07-nft-marketplace/src/*.sol:* --chain-id 8453

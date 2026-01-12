#!/bin/bash
# Verify lucky-draw on BaseScan
forge verify-contract $ADDRESS 02-lucky-draw/src/*.sol:* --chain-id 8453

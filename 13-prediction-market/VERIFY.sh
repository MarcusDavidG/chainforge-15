#!/bin/bash
# Verify prediction-market on BaseScan
forge verify-contract $ADDRESS 13-prediction-market/src/*.sol:* --chain-id 8453

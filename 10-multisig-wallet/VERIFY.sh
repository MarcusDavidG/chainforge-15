#!/bin/bash
# Verify multisig-wallet on BaseScan
forge verify-contract $ADDRESS 10-multisig-wallet/src/*.sol:* --chain-id 8453

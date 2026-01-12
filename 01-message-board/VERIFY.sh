#!/bin/bash
# Verify message-board on BaseScan
forge verify-contract $ADDRESS 01-message-board/src/*.sol:* --chain-id 8453

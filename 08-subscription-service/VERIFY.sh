#!/bin/bash
# Verify subscription-service on BaseScan
forge verify-contract $ADDRESS 08-subscription-service/src/*.sol:* --chain-id 8453

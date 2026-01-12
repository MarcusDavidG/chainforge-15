#!/bin/bash
# Verify skill-registry on BaseScan
forge verify-contract $ADDRESS 14-skill-registry/src/*.sol:* --chain-id 8453

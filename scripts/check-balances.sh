#!/bin/bash
echo "Checking wallet balance..."
cast balance $ADDRESS --rpc-url base_mainnet

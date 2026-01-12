#!/bin/bash
# Interact with MessageBoard contract

CONTRACT_ADDRESS="${MESSAGE_BOARD_ADDRESS}"
RPC_URL="${RPC_URL:-base_mainnet}"

if [ -z "$CONTRACT_ADDRESS" ]; then
    echo "Error: MESSAGE_BOARD_ADDRESS not set"
    exit 1
fi

echo "Interacting with MessageBoard at $CONTRACT_ADDRESS..."

# Post a message
echo "Posting message..."
cast send "$CONTRACT_ADDRESS" \
    "postMessage(string,uint256)" \
    "Hello from ChainForge! $(date +%s)" \
    0 \
    --value 0.0001ether \
    --rpc-url "$RPC_URL" \
    --private-key "$PRIVATE_KEY"

echo "Message posted successfully!"

# Get message count
MESSAGE_COUNT=$(cast call "$CONTRACT_ADDRESS" "getMessageCount()" --rpc-url "$RPC_URL")
echo "Total messages: $MESSAGE_COUNT"

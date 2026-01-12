#!/bin/bash
# Interact with TipJar contract

CONTRACT_ADDRESS="${TIP_JAR_ADDRESS}"
RPC_URL="${RPC_URL:-base_mainnet}"
CREATOR_ADDRESS="${CREATOR_ADDRESS:-$1}"

if [ -z "$CONTRACT_ADDRESS" ]; then
    echo "Error: TIP_JAR_ADDRESS not set"
    exit 1
fi

if [ -z "$CREATOR_ADDRESS" ]; then
    echo "Error: CREATOR_ADDRESS not provided"
    exit 1
fi

echo "Sending tip to $CREATOR_ADDRESS..."

# Send tip
cast send "$CONTRACT_ADDRESS" \
    "tip(address,string)" \
    "$CREATOR_ADDRESS" \
    "Great work on ChainForge-15! $(date +%Y-%m-%d)" \
    --value 0.001ether \
    --rpc-url "$RPC_URL" \
    --private-key "$PRIVATE_KEY"

echo "Tip sent successfully!"

# Check total tips for creator
TOTAL_TIPS=$(cast call "$CONTRACT_ADDRESS" "totalTips(address)" "$CREATOR_ADDRESS" --rpc-url "$RPC_URL")
echo "Total tips for creator: $TOTAL_TIPS"

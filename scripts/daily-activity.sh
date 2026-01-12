#!/bin/bash
# Daily activity generator for all contracts

echo "Running daily activity for ChainForge-15..."
echo "Date: $(date)"

# Source environment variables
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# Message Board
if [ -n "$MESSAGE_BOARD_ADDRESS" ]; then
    echo "Posting to Message Board..."
    ./scripts/interact-message-board.sh
fi

# Tip Jar
if [ -n "$TIP_JAR_ADDRESS" ] && [ -n "$CREATOR_ADDRESS" ]; then
    echo "Sending tip..."
    ./scripts/interact-tip-jar.sh "$CREATOR_ADDRESS"
fi

# Token Faucet
if [ -n "$TOKEN_FAUCET_ADDRESS" ]; then
    echo "Claiming from faucet..."
    cast send "$TOKEN_FAUCET_ADDRESS" "claim()" \
        --rpc-url base_mainnet \
        --private-key "$PRIVATE_KEY"
fi

# NFT Badges
if [ -n "$NFT_BADGES_ADDRESS" ]; then
    echo "Checking badges..."
    USER_ADDRESS=$(cast wallet address --private-key "$PRIVATE_KEY")
    BADGE_COUNT=$(cast call "$NFT_BADGES_ADDRESS" "getUserBadgeCount(address)" "$USER_ADDRESS" --rpc-url base_mainnet)
    echo "You have $BADGE_COUNT badges"
fi

echo "Daily activity completed!"
echo "Remember to commit this activity:"
echo "git add . && git commit -m 'activity: daily contract interactions $(date +%Y-%m-%d)' && git push"

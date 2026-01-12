#!/bin/bash
# Deploy all 15 contracts to Base Sepolia testnet

set -e

echo "Starting deployment of all 15 contracts to Base Sepolia..."

contracts=(
    "01-message-board:DeployMessageBoard"
    "02-lucky-draw:DeployLuckyDraw"
    "03-nft-badges:DeployNFTBadges"
    "04-token-faucet:DeployTokenFaucet"
    "05-escrow-service:DeployEscrowService"
    "06-dao-voting:DeployDAOVoting"
    "07-nft-marketplace:DeployNFTMarketplace"
    "08-subscription-service:DeploySubscriptionService"
    "09-crowdfunding:DeployCrowdfunding"
    "10-multisig-wallet:DeployMultiSigWallet"
    "11-token-vesting:DeployTokenVesting"
    "12-time-capsule:DeployTimeCapsule"
    "13-prediction-market:DeployPredictionMarket"
    "14-skill-registry:DeploySkillRegistry"
    "15-tip-jar:DeployTipJar"
)

for contract in "${contracts[@]}"; do
    IFS=":" read -r folder script <<< "$contract"
    echo "Deploying $folder..."
    
    forge script "$folder/script/Deploy.s.sol:$script" \
        --rpc-url base_sepolia \
        --broadcast \
        --verify \
        -vvvv
    
    echo "$folder deployed successfully!"
    sleep 2
done

echo "All contracts deployed to Base Sepolia!"

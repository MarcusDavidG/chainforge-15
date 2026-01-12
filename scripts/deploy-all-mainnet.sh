#!/bin/bash
# Deploy all 15 contracts to Base Mainnet

set -e

echo "WARNING: This will deploy to BASE MAINNET and cost real ETH!"
read -p "Are you sure you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Deployment cancelled."
    exit 1
fi

echo "Starting deployment of all 15 contracts to Base Mainnet..."

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

# Create deployment log
DEPLOY_LOG="deployments/mainnet-$(date +%Y%m%d-%H%M%S).log"
mkdir -p deployments

for contract in "${contracts[@]}"; do
    IFS=":" read -r folder script <<< "$contract"
    echo "Deploying $folder..." | tee -a "$DEPLOY_LOG"
    
    forge script "$folder/script/Deploy.s.sol:$script" \
        --rpc-url base_mainnet \
        --broadcast \
        --verify \
        -vvvv | tee -a "$DEPLOY_LOG"
    
    echo "$folder deployed successfully!" | tee -a "$DEPLOY_LOG"
    sleep 5
done

echo "All contracts deployed to Base Mainnet!"
echo "Deployment log saved to: $DEPLOY_LOG"

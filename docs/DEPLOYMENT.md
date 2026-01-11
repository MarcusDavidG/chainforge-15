# Deployment Guide

## Prerequisites

1. **Foundry installed**: `curl -L https://foundry.paradigm.xyz | bash && foundryup`
2. **Base Wallet with ETH**: For gas fees on Base mainnet or Sepolia testnet
3. **BaseScan API Key**: For contract verification (get from https://basescan.org/myapikey)

## Setup

### 1. Configure Environment

```bash
cp .env.example .env
# Edit .env and add your private key and BaseScan API key
```

### 2. Get Testnet ETH

For Base Sepolia testnet:
- Visit https://www.coinbase.com/faucets/base-ethereum-goerli-faucet
- Or bridge from Ethereum Sepolia

### 3. Verify Configuration

```bash
forge config
```

## Deployment Process

### Deploy to Testnet First (Recommended)

Test all contracts on Base Sepolia before mainnet deployment:

```bash
# Deploy individual project
forge script 01-message-board/script/Deploy.s.sol:DeployMessageBoard \
  --rpc-url base_sepolia \
  --broadcast \
  --verify \
  -vvvv

# Check deployment
cast code <CONTRACT_ADDRESS> --rpc-url base_sepolia
```

### Deploy to Base Mainnet

#### Step 1: Message Board
```bash
forge script 01-message-board/script/Deploy.s.sol:DeployMessageBoard \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 2: Lucky Draw
```bash
forge script 02-lucky-draw/script/Deploy.s.sol:DeployLuckyDraw \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 3: NFT Badges
```bash
forge script 03-nft-badges/script/Deploy.s.sol:DeployNFTBadges \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 4: Token Faucet
```bash
forge script 04-token-faucet/script/Deploy.s.sol:DeployTokenFaucet \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 5: Escrow Service
```bash
forge script 05-escrow-service/script/Deploy.s.sol:DeployEscrowService \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 6: DAO Voting
```bash
forge script 06-dao-voting/script/Deploy.s.sol:DeployDAOVoting \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 7: NFT Marketplace
```bash
forge script 07-nft-marketplace/script/Deploy.s.sol:DeployNFTMarketplace \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 8: Subscription Service
```bash
forge script 08-subscription-service/script/Deploy.s.sol:DeploySubscriptionService \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 9: Crowdfunding
```bash
forge script 09-crowdfunding/script/Deploy.s.sol:DeployCrowdfunding \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 10: MultiSig Wallet
```bash
forge script 10-multisig-wallet/script/Deploy.s.sol:DeployMultiSigWallet \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 11: Token Vesting
Note: Requires TOKEN_ADDRESS in .env
```bash
forge script 11-token-vesting/script/Deploy.s.sol:DeployTokenVesting \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 12: Time Capsule
```bash
forge script 12-time-capsule/script/Deploy.s.sol:DeployTimeCapsule \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 13: Prediction Market
```bash
forge script 13-prediction-market/script/Deploy.s.sol:DeployPredictionMarket \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 14: Skill Registry
```bash
forge script 14-skill-registry/script/Deploy.s.sol:DeploySkillRegistry \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

#### Step 15: Tip Jar
```bash
forge script 15-tip-jar/script/Deploy.s.sol:DeployTipJar \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

## Post-Deployment

### 1. Save Contract Addresses

Update the README.md with deployed contract addresses:

```markdown
| Message Board | 0x... | [View](https://basescan.org/address/0x...) |
```

### 2. Verify Contracts (if auto-verify failed)

```bash
forge verify-contract \
  <CONTRACT_ADDRESS> \
  <CONTRACT_PATH:CONTRACT_NAME> \
  --chain-id 8453 \
  --etherscan-api-key $BASESCAN_API_KEY
```

### 3. Interact with Contracts

```bash
# Example: Post a message
cast send <MESSAGE_BOARD_ADDRESS> \
  "postMessage(string,uint256)" \
  "Hello Base!" \
  0 \
  --value 0.0001ether \
  --rpc-url base_mainnet \
  --private-key $PRIVATE_KEY
```

### 4. Test Contracts

Make test transactions to generate activity for Base January metrics:

```bash
# Message Board: Post messages
# Lucky Draw: Create draw and buy tickets
# NFT Badges: Mint badges
# Token Faucet: Claim tokens
# etc...
```

## Troubleshooting

### Verification Failed

```bash
# Manually verify
forge verify-contract <ADDRESS> <CONTRACT> --chain-id 8453
```

### Transaction Failed

```bash
# Check gas prices
cast gas-price --rpc-url base_mainnet

# Increase gas limit
--gas-limit 500000
```

### RPC Issues

```bash
# Use alternative RPC
--rpc-url https://base.llamarpc.com
```

## Cost Estimation

Approximate deployment costs on Base mainnet (gas prices vary):

- Simple contracts (Message Board, Tip Jar): ~0.001-0.002 ETH
- Medium contracts (NFT Marketplace, DAO): ~0.003-0.005 ETH
- Complex contracts (MultiSig, Prediction Market): ~0.005-0.01 ETH

**Total estimated: ~0.05-0.1 ETH** for all 15 contracts

## Resources

- Base RPC: https://mainnet.base.org
- Base Sepolia RPC: https://sepolia.base.org
- BaseScan: https://basescan.org
- Base Docs: https://docs.base.org

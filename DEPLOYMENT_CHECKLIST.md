# 🚀 Deployment Checklist for ChainForge-15

## Pre-Deployment

### Setup
- [ ] Install Foundry (`curl -L https://foundry.paradigm.xyz | bash && foundryup`)
- [ ] Clone repository
- [ ] Run `forge install` to install dependencies
- [ ] Copy `.env.example` to `.env`
- [ ] Add `PRIVATE_KEY` to `.env`
- [ ] Add `BASESCAN_API_KEY` to `.env` (get from https://basescan.org/myapikey)
- [ ] Fund wallet with Base ETH (~0.5 ETH recommended for safety)

### Testing
- [ ] Run `forge build` to compile all contracts
- [ ] Run `forge test` to test contracts
- [ ] Test individual contracts: `forge test --match-path XX-project/test/*.sol -vvv`
- [ ] Fix any compilation or test errors

### Testnet Deployment (Base Sepolia)
- [ ] Get Base Sepolia ETH from faucet
- [ ] Deploy all 15 contracts to Base Sepolia first
- [ ] Verify contracts on BaseScan Sepolia
- [ ] Test interactions on testnet
- [ ] Document any issues

## Mainnet Deployment

### Day 1-2: Core Projects (1-5)

- [ ] **01 - Message Board**
  ```bash
  forge script 01-message-board/script/Deploy.s.sol:DeployMessageBoard --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Test posting a message
  - [ ] Update README with address

- [ ] **02 - Lucky Draw**
  ```bash
  forge script 02-lucky-draw/script/Deploy.s.sol:DeployLuckyDraw --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Create test draw
  - [ ] Update README

- [ ] **03 - NFT Badges**
  ```bash
  forge script 03-nft-badges/script/Deploy.s.sol:DeployNFTBadges --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Mint test badge
  - [ ] Update README

- [ ] **04 - Token Faucet**
  ```bash
  forge script 04-token-faucet/script/Deploy.s.sol:DeployTokenFaucet --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy faucet address
  - [ ] Copy token address
  - [ ] Claim test tokens
  - [ ] Update README

- [ ] **05 - Escrow Service**
  ```bash
  forge script 05-escrow-service/script/Deploy.s.sol:DeployEscrowService --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Create test escrow
  - [ ] Update README

### Day 2-3: Governance & Marketplace (6-8)

- [ ] **06 - DAO Voting**
  ```bash
  forge script 06-dao-voting/script/Deploy.s.sol:DeployDAOVoting --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Create test proposal
  - [ ] Update README

- [ ] **07 - NFT Marketplace**
  ```bash
  forge script 07-nft-marketplace/script/Deploy.s.sol:DeployNFTMarketplace --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy marketplace address
  - [ ] Copy NFT address
  - [ ] Mint and list NFT
  - [ ] Update README

- [ ] **08 - Subscription Service**
  ```bash
  forge script 08-subscription-service/script/Deploy.s.sol:DeploySubscriptionService --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Test subscription
  - [ ] Update README

### Day 3-4: Funding & Security (9-11)

- [ ] **09 - Crowdfunding**
  ```bash
  forge script 09-crowdfunding/script/Deploy.s.sol:DeployCrowdfunding --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Create test campaign
  - [ ] Update README

- [ ] **10 - MultiSig Wallet**
  ```bash
  forge script 10-multisig-wallet/script/Deploy.s.sol:DeployMultiSigWallet --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Test multi-sig flow
  - [ ] Update README

- [ ] **11 - Token Vesting**
  ```bash
  # Set TOKEN_ADDRESS in .env first (use token from project 04)
  forge script 11-token-vesting/script/Deploy.s.sol:DeployTokenVesting --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Create vesting schedule
  - [ ] Update README

### Day 4-5: Advanced Features (12-15)

- [ ] **12 - Time Capsule**
  ```bash
  forge script 12-time-capsule/script/Deploy.s.sol:DeployTimeCapsule --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Create test capsule
  - [ ] Update README

- [ ] **13 - Prediction Market**
  ```bash
  forge script 13-prediction-market/script/Deploy.s.sol:DeployPredictionMarket --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Create test market
  - [ ] Update README

- [ ] **14 - Skill Registry**
  ```bash
  forge script 14-skill-registry/script/Deploy.s.sol:DeploySkillRegistry --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Issue test certificate
  - [ ] Update README

- [ ] **15 - Tip Jar**
  ```bash
  forge script 15-tip-jar/script/Deploy.s.sol:DeployTipJar --rpc-url base_mainnet --broadcast --verify
  ```
  - [ ] Copy contract address
  - [ ] Send test tip
  - [ ] Update README

## Post-Deployment

### Documentation
- [ ] Update main README.md with all contract addresses
- [ ] Add BaseScan links for all contracts
- [ ] Verify all contracts are showing as verified on BaseScan
- [ ] Create interaction examples for each contract
- [ ] Write deployment summary blog post

### Testing & Activation
- [ ] Test all contracts with real transactions
- [ ] Post messages on Message Board (3-5/day)
- [ ] Create and participate in Lucky Draws
- [ ] Mint NFT badges for milestones
- [ ] Claim from Token Faucet daily
- [ ] Create and complete escrows
- [ ] Create DAO proposals and vote
- [ ] List and trade NFTs on marketplace
- [ ] Subscribe to Subscription Service
- [ ] Create crowdfunding campaigns
- [ ] Use Multi-Sig wallet
- [ ] Set up token vesting schedules
- [ ] Create time capsules
- [ ] Create and bet on prediction markets
- [ ] Issue skill certificates
- [ ] Send tips via Tip Jar

### Monitoring
- [ ] Track transaction counts on BaseScan
- [ ] Monitor Talent Protocol dashboard
- [ ] Ensure 30+ transactions/month per contract
- [ ] Check Builder Score weekly
- [ ] Track ranking position

### Promotion
- [ ] Share on Base Discord
- [ ] Tweet about deployment
- [ ] Post on Farcaster/Warpcast
- [ ] Create demo videos
- [ ] Write tutorials for each project
- [ ] Engage with Base community

### Maintenance
- [ ] Daily interactions with contracts
- [ ] Respond to any community testing
- [ ] Fix any discovered issues
- [ ] Update documentation as needed
- [ ] Track gas costs and ROI

## Success Metrics

- [ ] All 15 contracts deployed ✅
- [ ] All 15 contracts verified ✅
- [ ] 1,000+ total transactions
- [ ] 15/15 contracts active (30+ tx/month)
- [ ] Builder Score > 100
- [ ] Rank in top 200 (stretch: top 100)

## Emergency Contacts

- Base Discord: https://discord.gg/buildonbase
- BaseScan Support: support@basescan.org
- Talent Protocol: support@talentprotocol.com

---

**Good luck! 🚀 Let's build on Base!**

# 🚀 Quick Start Guide

## Get Started in 5 Minutes

### 1. Setup (2 min)

```bash
# Clone the repo
git clone https://github.com/MarcusDavidG/chainforge-15.git
cd chainforge-15

# Install dependencies
forge install

# Create environment file
cp .env.example .env
# Edit .env and add your PRIVATE_KEY and BASESCAN_API_KEY
```

### 2. Test Locally (2 min)

```bash
# Build all contracts
forge build --contracts 01-message-board/src

# Run tests
forge test --match-path "01-message-board/test/*.sol" -vv
```

### 3. Deploy to Testnet (1 min)

```bash
# Deploy Message Board to Base Sepolia
forge script 01-message-board/script/Deploy.s.sol:DeployMessageBoard \
  --rpc-url base_sepolia \
  --broadcast

# Note the deployed address!
```

## What You Have

✅ **15 Production-Ready Smart Contracts**
- All with tests
- All with deployment scripts
- All documented

✅ **Complete Documentation**
- Individual READMEs for each project
- Deployment guide
- Base January strategy guide

✅ **Ready for Base Mainnet**
- Optimized for Base L2
- Verified contract setup
- Low gas costs

## The 15 Projects at a Glance

### Beginner-Friendly (1-5)
1. **Message Board** - Post messages on-chain
2. **Lucky Draw** - Simple lottery system
3. **NFT Badges** - Achievement NFTs
4. **Token Faucet** - Distribute test tokens
5. **Escrow Service** - Secure payments

### Intermediate (6-10)
6. **DAO Voting** - Governance system
7. **NFT Marketplace** - Buy/sell NFTs
8. **Subscription Service** - Recurring payments
9. **Crowdfunding** - Raise funds
10. **MultiSig Wallet** - Shared treasury

### Advanced (11-15)
11. **Token Vesting** - Time-locked tokens
12. **Time Capsule** - Future messages
13. **Prediction Market** - Betting on outcomes
14. **Skill Registry** - On-chain credentials
15. **Tip Jar** - Creator monetization

## Next Steps

### For Base January 2026

1. **Deploy All 15 Contracts** (Days 1-5)
   - Follow DEPLOYMENT_CHECKLIST.md
   - Deploy to Base mainnet
   - Verify all contracts

2. **Generate Transactions** (Days 5-25)
   - Interact with contracts daily
   - Target 30+ transactions per contract
   - See BASE_JANUARY.md for strategy

3. **Build Community** (Days 20-31)
   - Share on social media
   - Create tutorials
   - Engage Base community

### For Learning

Pick projects by interest:
- **DeFi**: 4, 7, 9, 11, 13
- **NFTs**: 3, 7, 12
- **Governance**: 6, 10, 14
- **Social**: 1, 2, 8, 15
- **Infrastructure**: 5, 11, 12

## Common Commands

```bash
# Build specific project
forge build --contracts XX-project-name/src

# Test specific project
forge test --match-path "XX-project-name/test/*.sol" -vvv

# Deploy to testnet
forge script XX-project-name/script/Deploy.s.sol:DeployXX \
  --rpc-url base_sepolia \
  --broadcast \
  --verify

# Deploy to mainnet
forge script XX-project-name/script/Deploy.s.sol:DeployXX \
  --rpc-url base_mainnet \
  --broadcast \
  --verify

# Check contract
cast code <ADDRESS> --rpc-url base_mainnet
```

## Resources

- **Main README**: Comprehensive project overview
- **DEPLOYMENT_CHECKLIST.md**: Step-by-step deployment
- **BASE_JANUARY.md**: Contest strategy & timeline
- **docs/DEPLOYMENT.md**: Detailed deployment guide
- **docs/**: Individual project READMEs in each folder

## Get Help

- **GitHub Issues**: https://github.com/MarcusDavidG/chainforge-15/issues
- **Base Discord**: https://discord.gg/buildonbase
- **Base Docs**: https://docs.base.org
- **Foundry Book**: https://book.getfoundry.sh

## Estimated Costs

- **Deployment**: ~0.05-0.1 ETH total
- **Testing Transactions**: ~0.15-0.3 ETH/month
- **Total for Base January**: ~0.2-0.4 ETH

**Potential Reward**: Share of 5 ETH (top 500 builders)

## Quick Tips

💡 **Deploy early** - Get contracts live in first week
💡 **Test on Sepolia first** - Catch bugs on testnet
💡 **Generate activity** - Aim for 30+ tx/contract/month
💡 **Document everything** - Strong GitHub presence helps
💡 **Engage community** - Share your work

---

**Ready to build? Let's go! 🚀**

```bash
# Start with the simplest project
cd 01-message-board
forge test -vv

# Deploy when ready
forge script script/Deploy.s.sol --rpc-url base_sepolia --broadcast
```

Good luck with Base January 2026! 🔵

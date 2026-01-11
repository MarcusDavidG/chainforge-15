# ⚡ ChainForge-15

> **15 creative smart contract experiments on Base** - A curated collection of standalone projects showcasing diverse patterns and use cases on Base L2.

Built for **Base January 2026** - demonstrating versatility in smart contract development from simple message boards to complex DeFi protocols.

## 🎯 Project Overview

This repository contains 15 independent mini-projects, each with its own smart contract, tests, and deployment scripts. Each project explores different blockchain use cases and Solidity patterns.

## 📦 The 15 Projects

| # | Project | Description | Key Features |
|---|---------|-------------|--------------|
| 01 | **Message Board** | Decentralized bulletin board | Post/edit messages, categories, fees |
| 02 | **Lucky Draw** | On-chain lottery system | Ticket sales, random winner, auto-payout |
| 03 | **NFT Badges** | Achievement badge system | ERC-721, batch minting, metadata |
| 04 | **Token Faucet** | Test token distribution | ERC-20, rate limiting, cooldowns |
| 05 | **Escrow Service** | Trustless payment escrow | Multi-party, arbitration, disputes |
| 06 | **DAO Voting** | Simple governance system | Proposals, weighted votes, execution |
| 07 | **NFT Marketplace** | Buy/sell NFT platform | Listings, offers, fee distribution |
| 08 | **Subscription Service** | Recurring payments | Time-based subscriptions, renewals |
| 09 | **Crowdfunding** | Kickstarter-style fundraising | Goals, deadlines, refund mechanism |
| 10 | **Multi-Sig Wallet** | Collaborative treasury | M-of-N signatures, proposal system |
| 11 | **Token Vesting** | Time-locked token release | Cliff vesting, linear schedules, revocable |
| 12 | **Time Capsule** | Future message delivery | Unlock dates, recipient locks, inheritance |
| 13 | **Prediction Market** | Binary outcome betting | Pools, proportional payouts, resolution |
| 14 | **Skill Registry** | Professional credentials | Issue certificates, endorsements, revocation |
| 15 | **Tip Jar** | Creator monetization | Tips with messages, leaderboard, withdraw |

## 🛠 Tech Stack

- **Framework**: Foundry
- **Language**: Solidity ^0.8.24
- **Chain**: Base (Mainnet & Sepolia Testnet)
- **Libraries**: OpenZeppelin Contracts
- **Testing**: Forge

## 🚀 Quick Start

### Prerequisites

```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Clone the repository
git clone https://github.com/MarcusDavidG/chainforge-15.git
cd chainforge-15

# Install dependencies
forge install
```

### Build All Contracts

```bash
forge build
```

### Run Tests

```bash
# Test all projects
forge test

# Test specific project
forge test --match-path 01-message-board/test/MessageBoard.t.sol -vvv

# Test with gas reports
forge test --gas-report
```

## 📝 Project Structure

```
chainforge-15/
├── 01-message-board/
│   ├── src/MessageBoard.sol
│   ├── test/MessageBoard.t.sol
│   ├── script/Deploy.s.sol
│   └── README.md
├── 02-lucky-draw/
│   └── ...
├── [03-15 following same pattern]
├── foundry.toml
├── README.md
└── docs/
```

## 🌐 Deployment

### Setup Environment

Create a `.env` file:

```bash
PRIVATE_KEY=your_private_key_here
BASESCAN_API_KEY=your_basescan_api_key_here
```

### Deploy Individual Projects

#### To Base Sepolia (Testnet)

```bash
# Example: Deploy Message Board
forge script 01-message-board/script/Deploy.s.sol:DeployMessageBoard \
  --rpc-url base_sepolia \
  --broadcast \
  --verify

# Deploy Lucky Draw
forge script 02-lucky-draw/script/Deploy.s.sol:DeployLuckyDraw \
  --rpc-url base_sepolia \
  --broadcast \
  --verify
```

#### To Base Mainnet

```bash
# Example: Deploy Message Board to mainnet
forge script 01-message-board/script/Deploy.s.sol:DeployMessageBoard \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

### Deploy All Projects

```bash
# Coming soon: Master deployment script
./deploy-all.sh base_sepolia
```

## 📊 Contract Addresses

### Base Mainnet

| Project | Contract Address | BaseScan |
|---------|------------------|----------|
| Message Board | TBD | [View](https://basescan.org) |
| Lucky Draw | TBD | [View](https://basescan.org) |
| NFT Badges | TBD | [View](https://basescan.org) |
| Token Faucet | TBD | [View](https://basescan.org) |
| Escrow Service | TBD | [View](https://basescan.org) |
| DAO Voting | TBD | [View](https://basescan.org) |
| NFT Marketplace | TBD | [View](https://basescan.org) |
| Subscription Service | TBD | [View](https://basescan.org) |
| Crowdfunding | TBD | [View](https://basescan.org) |
| Multi-Sig Wallet | TBD | [View](https://basescan.org) |
| Token Vesting | TBD | [View](https://basescan.org) |
| Time Capsule | TBD | [View](https://basescan.org) |
| Prediction Market | TBD | [View](https://basescan.org) |
| Skill Registry | TBD | [View](https://basescan.org) |
| Tip Jar | TBD | [View](https://basescan.org) |

## 🎓 Learning Objectives

Each project demonstrates different concepts:

- **01-02**: Basic contract patterns (storage, payments, events)
- **03-04**: Token standards (ERC-721, ERC-20)
- **05-06**: Multi-party interactions (escrow, voting)
- **07-08**: Marketplace mechanics (listings, subscriptions)
- **09-10**: Advanced patterns (crowdfunding, multi-sig)
- **11-12**: Time-based logic (vesting, time locks)
- **13-15**: Complex state machines (predictions, registries, tips)

## 🔒 Security Considerations

⚠️ **Important**: These contracts are educational demonstrations. Before mainnet deployment:

1. Conduct thorough security audits
2. Add comprehensive access controls
3. Implement emergency pause mechanisms
4. Test extensively on testnet
5. Consider formal verification for financial contracts

## 🤝 Contributing

This is a learning project for Base January 2026. Feel free to:

- Fork and experiment
- Report bugs or issues
- Suggest improvements
- Add your own creative projects

## 📜 License

MIT License - see [LICENSE](LICENSE) for details

## 🔗 Links

- **Base Docs**: https://docs.base.org
- **Foundry Book**: https://book.getfoundry.sh
- **OpenZeppelin**: https://docs.openzeppelin.com
- **Base January**: https://talent.app/~/earn/base-january

## 👨‍💻 Author

Built with ⚡ for Base January 2026

---

**⭐ Star this repo if you find it useful!**

*Part of the Base January 2026 builder initiative*

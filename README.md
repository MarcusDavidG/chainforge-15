# ChainForge-15

> **15 creative smart contract experiments on Base** - A curated collection of standalone projects showcasing diverse patterns and use cases on Base L2.

Built for **Base** - demonstrating versatility in smart contract development from simple message boards to complex DeFi protocols.

## Project Overview

This repository contains 15 independent mini-projects, each with its own smart contract, tests, and deployment scripts. Each project explores different blockchain use cases and Solidity patterns.

## The 15 Projects

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

## Tech Stack

- **Framework**: Foundry
- **Language**: Solidity ^0.8.24
- **Chain**: Base (Mainnet & Sepolia Testnet)
- **Libraries**: OpenZeppelin Contracts
- **Testing**: Forge

## Quick Start

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

## Project Structure

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

## Deployment

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

## Contract Addresses

### Base Mainnet (Deployed & Verified January 12, 2026)

All contracts are **LIVE, DEPLOYED, and VERIFIED** on Base Mainnet (Chain ID: 8453)

| Project | Contract Address | Status | BaseScan |
|---------|------------------|--------|----------|
| Message Board | `0xBe3dC286Dd61004fC05779Bd19E7Da4De61301d4` | ✅ Verified | [View Code](https://basescan.org/address/0xBe3dC286Dd61004fC05779Bd19E7Da4De61301d4#code) |
| Lucky Draw | `0xAeb94D997A26411550166bEe1b6da7f85a060240` | ✅ Verified | [View Code](https://basescan.org/address/0xAeb94D997A26411550166bEe1b6da7f85a060240#code) |
| NFT Badges | `0xF39CF694CB195EA96f1735A2Ba62f0940260F30a` | ✅ Verified | [View Code](https://basescan.org/address/0xF39CF694CB195EA96f1735A2Ba62f0940260F30a#code) |
| Token Faucet | `0xecf8698032C271F25b49749B6D3b8CF59D52d043` | ✅ Verified | [View Code](https://basescan.org/address/0xecf8698032C271F25b49749B6D3b8CF59D52d043#code) |
| Escrow Service | `0x4957e1e1f218eb4f0fD12Af5f94573E3EC799285` | ✅ Verified | [View Code](https://basescan.org/address/0x4957e1e1f218eb4f0fD12Af5f94573E3EC799285#code) |
| DAO Voting | `0xA9D811e31Aa66460C17b812fA625b79273c58668` | ✅ Verified | [View Code](https://basescan.org/address/0xA9D811e31Aa66460C17b812fA625b79273c58668#code) |
| NFT Marketplace | `0xDCEdc185f7caB8E21861C24909Cc327f1fd2Bb0d` | ✅ Verified | [View Code](https://basescan.org/address/0xDCEdc185f7caB8E21861C24909Cc327f1fd2Bb0d#code) |
| SimpleNFT (Helper) | `0x3D0Bde73fb1AeC16E097Bb0aBA405aaD8F346473` | ✅ Verified | [View Code](https://basescan.org/address/0x3D0Bde73fb1AeC16E097Bb0aBA405aaD8F346473#code) |
| Subscription Service | `0x81c8d55A3B0ed4e37E90a984a4340582B4330d25` | ✅ Verified | [View Code](https://basescan.org/address/0x81c8d55A3B0ed4e37E90a984a4340582B4330d25#code) |
| Crowdfunding | `0xFeC7d44afd2fED73c55d85353D6d9727f623E7D1` | ✅ Verified | [View Code](https://basescan.org/address/0xFeC7d44afd2fED73c55d85353D6d9727f623E7D1#code) |
| Multi-Sig Wallet | `0x42e0F0d5f7f3903C52B4dAF27f358e6b259FCf2b` | ✅ Verified | [View Code](https://basescan.org/address/0x42e0F0d5f7f3903C52B4dAF27f358e6b259FCf2b#code) |
| Token Vesting | `0xEAF919E1E12B40709Ef5Cf6B10fF9Cb838b56CC5` | ✅ Verified | [View Code](https://basescan.org/address/0xEAF919E1E12B40709Ef5Cf6B10fF9Cb838b56CC5#code) |
| Time Capsule | `0x387862150b9285325f1489Ac14f8fe933472A6B3` | ✅ Verified | [View Code](https://basescan.org/address/0x387862150b9285325f1489Ac14f8fe933472A6B3#code) |
| Prediction Market | `0x3A775022c593898b7D3b324D54f1F572aB92Cc8E` | ✅ Verified | [View Code](https://basescan.org/address/0x3A775022c593898b7D3b324D54f1F572aB92Cc8E#code) |
| Skill Registry | `0xc1700E821BF2AA6132f93241e0e2F5e1eb85A20E` | ✅ Verified | [View Code](https://basescan.org/address/0xc1700E821BF2AA6132f93241e0e2F5e1eb85A20E#code) |
| Tip Jar | `0x2da0E5Dd36756BEA7E21dfD5d8e8b224B2FAABae` | ✅ Verified | [View Code](https://basescan.org/address/0x2da0E5Dd36756BEA7E21dfD5d8e8b224B2FAABae#code) |

**Deployer Address**: `0xDD7ECB0428d2071532db71437e02C7FD2922Ea31`  
**Total Contracts**: 16 (15 main + 1 helper NFT)  
**Verification Status**: All 16 contracts verified on BaseScan ✅  
**Compiler Version**: Solidity 0.8.24

### Verification Benefits
- Full source code publicly viewable
- Read/Write functions available on BaseScan UI
- Contract ABI downloadable
- Enhanced trust and transparency
- Higher ranking on blockchain explorers

## Learning Objectives

Each project demonstrates different concepts:

- **01-02**: Basic contract patterns (storage, payments, events)
- **03-04**: Token standards (ERC-721, ERC-20)
- **05-06**: Multi-party interactions (escrow, voting)
- **07-08**: Marketplace mechanics (listings, subscriptions)
- **09-10**: Advanced patterns (crowdfunding, multi-sig)
- **11-12**: Time-based logic (vesting, time locks)
- **13-15**: Complex state machines (predictions, registries, tips)

## Security Considerations

**Important**: These contracts are educational demonstrations. Before mainnet deployment:

1. Conduct thorough security audits
2. Add comprehensive access controls
3. Implement emergency pause mechanisms
4. Test extensively on testnet
5. Consider formal verification for financial contracts

## Contributing

This is a learning project for Base January 2026. Feel free to:

- Fork and experiment
- Report bugs or issues
- Suggest improvements
- Add your own creative projects

## License

MIT License - see [LICENSE](LICENSE) for details

## Links

- **Base Docs**: https://docs.base.org
- **Foundry Book**: https://book.getfoundry.sh
- **OpenZeppelin**: https://docs.openzeppelin.com
- **Base January**: https://talent.app/~/earn/base-january

## Author

Built for Base January 2026

---

**Star this repo if you find it useful!**

*Part of the Base January 2026 builder initiative*

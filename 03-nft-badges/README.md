# 03 - NFT Badges

Achievement badge system using ERC-721 NFTs to recognize milestones and accomplishments.

## Features

- **Mint Badges**: Owner can mint achievement badges to users
- **Batch Minting**: Mint same badge to multiple recipients
- **Metadata Storage**: On-chain badge details (name, description, milestone)
- **Transferable**: Badges can be transferred like standard NFTs
- **User Tracking**: Track all badges owned by each user

## Usage

```solidity
// Mint a badge
uint256 tokenId = badges.mintBadge(
    user,
    "First Transaction",
    "Completed your first on-chain transaction",
    "ipfs://QmX...",
    1
);

// Batch mint to multiple users
address[] memory users = [user1, user2, user3];
badges.batchMintBadge(users, "Early Adopter", "Joined in first month", "ipfs://...", 100);
```

## Deployment

```bash
forge script script/Deploy.s.sol:DeployNFTBadges --rpc-url base_sepolia --broadcast --verify
```

**Base Mainnet**: TBD

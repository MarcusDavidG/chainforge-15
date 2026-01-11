# 01 - Message Board

A decentralized bulletin board where users can post, edit, and categorize messages on-chain.

## Features

- **Post Messages**: Pay a small fee to post messages (default: 0.0001 ETH)
- **Edit Messages**: Authors can edit their own messages
- **Categories**: Organize messages by category
- **Message History**: All messages are permanently stored on-chain
- **Fee Management**: Owner can adjust posting fees

## Contract Details

- **Network**: Base Mainnet
- **Solidity Version**: 0.8.24
- **License**: MIT

## Functions

### Public Functions

- `postMessage(string content, uint256 category)` - Post a new message (payable)
- `editMessage(uint256 messageId, string newContent)` - Edit your message
- `getMessage(uint256 messageId)` - Get message details
- `getMessageCount()` - Get total number of messages
- `getMessagesByCategory(uint256 category)` - Get all messages in a category

### Owner Functions

- `setPostFee(uint256 newFee)` - Update posting fee
- `withdraw()` - Withdraw collected fees

## Usage Example

```solidity
// Post a message
uint256 messageId = board.postMessage{value: 0.0001 ether}("Hello Base!", 0);

// Edit your message
board.editMessage(messageId, "Hello Base Community!");

// Get message
(address author, string memory content, , , ) = board.getMessage(messageId);
```

## Deployment

```bash
# Deploy to Base Sepolia (testnet)
forge script script/Deploy.s.sol:DeployMessageBoard --rpc-url base_sepolia --broadcast --verify

# Deploy to Base Mainnet
forge script script/Deploy.s.sol:DeployMessageBoard --rpc-url base_mainnet --broadcast --verify
```

## Testing

```bash
forge test --match-path test/MessageBoard.t.sol -vvv
```

## Contract Address

**Base Mainnet**: TBD (will be updated after deployment)
**Base Sepolia**: TBD

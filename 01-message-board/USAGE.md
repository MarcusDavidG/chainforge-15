# MessageBoard Usage Guide

## Overview
The MessageBoard contract allows users to post messages to a decentralized bulletin board with categories.

## Contract Address
**Base Mainnet**: TBD  
**Base Sepolia**: TBD

## Basic Usage

### Posting a Message

```solidity
// Post a message in category 0
board.postMessage{value: 0.0001 ether}("Hello Base!", 0);
```

Using Cast CLI:
```bash
cast send $MESSAGE_BOARD_ADDRESS \
  "postMessage(string,uint256)" \
  "Hello Base!" \
  0 \
  --value 0.0001ether \
  --rpc-url base_mainnet \
  --private-key $PRIVATE_KEY
```

### Editing Your Message

```solidity
// Edit message with ID 0
board.editMessage(0, "Updated message content");
```

Using Cast:
```bash
cast send $MESSAGE_BOARD_ADDRESS \
  "editMessage(uint256,string)" \
  0 \
  "Updated message" \
  --rpc-url base_mainnet \
  --private-key $PRIVATE_KEY
```

### Reading Messages

```solidity
// Get message details
(address author, string memory content, uint256 timestamp, uint256 category, bool edited) = board.getMessage(0);
```

Using Cast:
```bash
cast call $MESSAGE_BOARD_ADDRESS \
  "getMessage(uint256)" \
  0 \
  --rpc-url base_mainnet
```

### Get Total Message Count

```bash
cast call $MESSAGE_BOARD_ADDRESS \
  "getMessageCount()" \
  --rpc-url base_mainnet
```

### Get Messages by Category

```bash
cast call $MESSAGE_BOARD_ADDRESS \
  "getMessagesByCategory(uint256)" \
  1 \
  --rpc-url base_mainnet
```

## Categories

You can organize messages by category (any uint256 value):
- 0: General
- 1: Announcements
- 2: Questions
- 3: Technical
- 4: Social
- (Custom categories as needed)

## Fees

- **Posting Fee**: 0.0001 ETH (default, adjustable by owner)
- **Editing**: Free
- **Reading**: Free

## Owner Functions

### Update Posting Fee

```bash
cast send $MESSAGE_BOARD_ADDRESS \
  "setPostFee(uint256)" \
  100000000000000 \
  --rpc-url base_mainnet \
  --private-key $PRIVATE_KEY
```

### Withdraw Collected Fees

```bash
cast send $MESSAGE_BOARD_ADDRESS \
  "withdraw()" \
  --rpc-url base_mainnet \
  --private-key $PRIVATE_KEY
```

## Events

Monitor these events:
- `MessagePosted(uint256 indexed messageId, address indexed author, string content, uint256 category)`
- `MessageEdited(uint256 indexed messageId, string newContent)`
- `FeeUpdated(uint256 newFee)`

## Limits

- Message length: 1-500 characters
- Minimum fee: Set by owner
- Only authors can edit their own messages

## Web3.js Example

```javascript
const contract = new web3.eth.Contract(ABI, MESSAGE_BOARD_ADDRESS);

// Post message
await contract.methods
  .postMessage("Hello from Web3!", 0)
  .send({ from: account, value: web3.utils.toWei('0.0001', 'ether') });

// Read message
const message = await contract.methods.getMessage(0).call();
console.log(message.content);
```

## Ethers.js Example

```javascript
const contract = new ethers.Contract(MESSAGE_BOARD_ADDRESS, ABI, signer);

// Post message
const tx = await contract.postMessage("Hello from Ethers!", 0, {
  value: ethers.utils.parseEther('0.0001')
});
await tx.wait();

// Read message
const message = await contract.getMessage(0);
console.log(message.content);
```

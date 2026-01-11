# 04 - Token Faucet

Test token distribution system with rate limiting and cooldown periods.

## Features

- **ERC-20 Token**: Custom faucet token for testing
- **Daily Claims**: Users can claim tokens once per cooldown period (24h)
- **Rate Limiting**: Prevents abuse with cooldown mechanism
- **Refillable**: Can be refilled by anyone
- **Configurable**: Owner can adjust claim amount and cooldown

## Usage

```solidity
// Claim tokens
faucet.claim(); // Receive 100 FTKN

// Check cooldown
uint256 timeLeft = faucet.getTimeUntilNextClaim(msg.sender);
```

**Base Mainnet**: TBD

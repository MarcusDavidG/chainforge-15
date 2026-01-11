# 02 - Lucky Draw

An on-chain lottery system where users can buy tickets and winners are selected randomly.

## Features

- **Create Draws**: Owner can create lottery draws with custom ticket prices and durations
- **Buy Tickets**: Anyone can purchase tickets before the draw ends
- **Random Selection**: Pseudo-random winner selection on-chain
- **Automatic Payouts**: Winner and owner fee distributed automatically
- **Prize Pool**: Transparent prize pool tracking

## Contract Details

- **Network**: Base Mainnet
- **Solidity Version**: 0.8.24
- **Owner Fee**: 5% (configurable)

## Functions

### Owner Functions

- `createDraw(uint256 ticketPrice, uint256 duration)` - Create new draw
- `setOwnerFee(uint256 feePercent)` - Update owner fee (max 20%)

### Public Functions

- `buyTicket(uint256 drawId)` - Purchase lottery ticket (payable)
- `selectWinner(uint256 drawId)` - Finalize draw and select winner
- `getDrawDetails(uint256 drawId)` - Get draw information
- `getParticipants(uint256 drawId)` - Get all participants
- `getDrawCount()` - Get total number of draws

## Usage Example

```solidity
// Create a draw (1 hour duration, 0.01 ETH per ticket)
uint256 drawId = lottery.createDraw(0.01 ether, 1 hours);

// Buy ticket
lottery.buyTicket{value: 0.01 ether}(drawId);

// After draw ends, select winner
lottery.selectWinner(drawId);
```

## Deployment

```bash
forge script script/Deploy.s.sol:DeployLuckyDraw --rpc-url base_sepolia --broadcast --verify
```

## Contract Address

**Base Mainnet**: TBD

# Deployment Guide for lucky-draw

## Testnet Deployment
```bash
forge script script/Deploy.s.sol --rpc-url base_sepolia --broadcast
```

## Mainnet Deployment
```bash
forge script script/Deploy.s.sol --rpc-url base_mainnet --broadcast --verify
```

## Post-Deployment
1. Save contract address
2. Verify on BaseScan
3. Test interactions

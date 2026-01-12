# Ethers.js Examples for multisig-wallet

## Setup
```javascript
const ethers = require('ethers');
const provider = new ethers.providers.JsonRpcProvider('https://mainnet.base.org');
```

## Contract Instance
```javascript
const contract = new ethers.Contract(ADDRESS, ABI, signer);
```

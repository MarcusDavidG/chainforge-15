# Integration Examples for escrow-service

## Web3.js
```javascript
const contract = new web3.eth.Contract(ABI, ADDRESS);
```

## Ethers.js
```javascript
const contract = new ethers.Contract(ADDRESS, ABI, signer);
```

## Hardhat
```javascript
const Contract = await ethers.getContractAt("escrow-service", ADDRESS);
```

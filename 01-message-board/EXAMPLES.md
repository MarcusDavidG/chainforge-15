# Integration Examples for message-board

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
const Contract = await ethers.getContractAt("message-board", ADDRESS);
```

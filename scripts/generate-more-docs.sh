#!/bin/bash
# Generate even more documentation commits

# Add API documentation
for i in {1..15}; do
    num=$(printf "%02d" $i)
    folder=$(ls -d ${num}-* 2>/dev/null | head -1)
    if [ -n "$folder" ]; then
        contract=$(basename "$folder" | cut -d'-' -f2-)
        cat > "$folder/API.md" << API
# API Reference for $contract

## Read Functions
- View functions that don't modify state
- No gas costs

## Write Functions  
- Functions that modify blockchain state
- Require gas fees

## Events
- Emitted during transactions
- Can be monitored off-chain
API
        git add "$folder/API.md"
        git commit -m "docs: add API reference for $contract"
    fi
done

# Add example integrations
for i in {1..15}; do
    num=$(printf "%02d" $i)
    folder=$(ls -d ${num}-* 2>/dev/null | head -1)
    if [ -n "$folder" ]; then
        contract=$(basename "$folder" | cut -d'-' -f2-)
        cat > "$folder/EXAMPLES.md" << EXAMPLES
# Integration Examples for $contract

## Web3.js
\`\`\`javascript
const contract = new web3.eth.Contract(ABI, ADDRESS);
\`\`\`

## Ethers.js
\`\`\`javascript
const contract = new ethers.Contract(ADDRESS, ABI, signer);
\`\`\`

## Hardhat
\`\`\`javascript
const Contract = await ethers.getContractAt("$contract", ADDRESS);
\`\`\`
EXAMPLES
        git add "$folder/EXAMPLES.md"
        git commit -m "docs: add integration examples for $contract"
    fi
done

echo "✅ More docs generated!"

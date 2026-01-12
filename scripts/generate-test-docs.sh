#!/bin/bash
# Generate testing documentation

for i in {1..15}; do
    num=$(printf "%02d" $i)
    folder=$(ls -d ${num}-* 2>/dev/null | head -1)
    if [ -n "$folder" ]; then
        contract=$(basename "$folder" | cut -d'-' -f2-)
        
        # Testing guide
        cat > "$folder/TESTING.md" << TEST
# Testing Guide for $contract

## Running Tests
\`\`\`bash
forge test --match-path test/$contract.t.sol
\`\`\`

## Test Coverage
\`\`\`bash
forge coverage --match-path test/$contract.t.sol
\`\`\`

## Gas Reports
\`\`\`bash
forge test --gas-report
\`\`\`
TEST
        git add "$folder/TESTING.md"
        git commit -m "docs: add testing guide for $contract"
        
        # Deployment guide
        cat > "$folder/DEPLOY.md" << DEPLOY
# Deployment Guide for $contract

## Testnet Deployment
\`\`\`bash
forge script script/Deploy.s.sol --rpc-url base_sepolia --broadcast
\`\`\`

## Mainnet Deployment
\`\`\`bash
forge script script/Deploy.s.sol --rpc-url base_mainnet --broadcast --verify
\`\`\`

## Post-Deployment
1. Save contract address
2. Verify on BaseScan
3. Test interactions
DEPLOY
        git add "$folder/DEPLOY.md"
        git commit -m "docs: add deployment guide for $contract"
    fi
done

echo "✅ Test docs generated!"

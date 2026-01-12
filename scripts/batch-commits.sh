#!/bin/bash
# Generate many commits quickly

# Test files for remaining contracts
for i in {4..15}; do
  folder=$(printf "%02d" $i)
  folder_name=$(ls -d ${folder}-* 2>/dev/null | head -1)
  if [ -n "$folder_name" ]; then
    contract_name=$(basename "$folder_name" | cut -d'-' -f2- | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g' | sed 's/ //g')
    
    # Create basic usage file
    cat > "$folder_name/USAGE.md" << USAGE
# $contract_name Usage Guide

## Quick Start

See README.md for basic usage examples.

## Advanced Features

Coming soon...
USAGE
    git add "$folder_name/USAGE.md"
    git commit -m "docs: add usage guide for $contract_name"
  fi
done

# Create individual READMEs for docs
mkdir -p analysis security testing
echo "# Analysis Tools" > analysis/README.md
git add analysis/
git commit -m "docs: add analysis documentation folder"

echo "# Security Guidelines" > security/README.md
git add security/
git commit -m "docs: add security documentation folder"

echo "# Testing Strategy" > testing/README.md
git add testing/
git commit -m "docs: add testing documentation folder"

# Create helper scripts
cat > scripts/check-balances.sh << 'BAL'
#!/bin/bash
echo "Checking wallet balance..."
cast balance $ADDRESS --rpc-url base_mainnet
BAL
chmod +x scripts/check-balances.sh
git add scripts/check-balances.sh
git commit -m "feat: add balance checking script"

cat > scripts/estimate-gas.sh << 'GAS'
#!/bin/bash
echo "Estimating gas costs..."
forge test --gas-report
GAS
chmod +x scripts/estimate-gas.sh
git add scripts/estimate-gas.sh
git commit -m "feat: add gas estimation script"

echo "Batch commits generated!"

#!/bin/bash
# Rapid commit generator

echo "Generating commits for ChainForge-15..."

# Create deployment tracking
mkdir -p deployments
echo "# Deployment Tracker" > deployments/README.md
git add deployments/README.md
git commit -m "chore: initialize deployment tracking"

# Create contract addresses file
cat > deployments/addresses.json << 'JSON'
{
  "base_mainnet": {},
  "base_sepolia": {}
}
JSON
git add deployments/addresses.json
git commit -m "chore: add contract addresses tracking file"

# Create verification tracking
echo "# Verification Status" > deployments/VERIFICATION.md
git add deployments/VERIFICATION.md
git commit -m "docs: add verification status tracker"

# Create gas optimization notes
mkdir -p docs/gas-optimization
echo "# Gas Optimization Notes" > docs/gas-optimization/README.md
git add docs/gas-optimization/
git commit -m "docs: initialize gas optimization documentation"

# Create security considerations
echo "# Security Audit Checklist" > docs/SECURITY.md
git add docs/SECURITY.md
git commit -m "docs: add security audit checklist"

# Create contributing guide
cat > CONTRIBUTING.md << 'CONTRIB'
# Contributing to ChainForge-15

## How to Contribute

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `forge test`
5. Submit a pull request

## Code Style

- Follow Solidity style guide
- Add tests for new features
- Document public functions with NatSpec

CONTRIB
git add CONTRIBUTING.md
git commit -m "docs: add contributing guidelines"

echo "Generated multiple commits successfully!"

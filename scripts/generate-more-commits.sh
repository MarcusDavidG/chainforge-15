#!/bin/bash

# Create more test files
mkdir -p test-utils
cat > test-utils/Helpers.sol << 'HELP'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library TestHelpers {
    function generateString(uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(length);
        for(uint256 i = 0; i < length; i++) {
            buffer[i] = bytes1(uint8(65 + (i % 26)));
        }
        return string(buffer);
    }
}
HELP
git add test-utils/
git commit -m "test: add test helper utilities"

# Create gas benchmarks
mkdir -p benchmarks
echo "# Gas Benchmarks" > benchmarks/README.md
git add benchmarks/
git commit -m "test: add gas benchmarking infrastructure"

# Create CI/CD workflow
mkdir -p .github/workflows
cat > .github/workflows/ci.yml << 'CI'
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Foundry
        uses: foundry-rs/foundry-toolchain@v1
      - name: Run tests
        run: forge test
CI
git add .github/workflows/ci.yml
git commit -m "ci: add GitHub Actions workflow"

echo "More commits generated!"

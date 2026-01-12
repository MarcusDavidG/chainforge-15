#!/bin/bash
source .env

echo "🔍 Verifying all 15 contracts on BaseScan..."

# Contract 2: LuckyDraw
echo "Verifying LuckyDraw..."
forge verify-contract 0xAeb94D997A26411550166bEe1b6da7f85a060240 \
  src/LuckyDraw.sol:LuckyDraw \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 02-lucky-draw

sleep 3

# Contract 3: NFTBadges
echo "Verifying NFTBadges..."
forge verify-contract 0xF39CF694CB195EA96f1735A2Ba62f0940260F30a \
  src/NFTBadges.sol:NFTBadges \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 03-nft-badges

sleep 3

# Contract 4: TokenFaucet
echo "Verifying TokenFaucet..."
forge verify-contract 0xecf8698032C271F25b49749B6D3b8CF59D52d043 \
  src/TokenFaucet.sol:TokenFaucet \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 04-token-faucet

sleep 3

# Contract 5: EscrowService
echo "Verifying EscrowService..."
forge verify-contract 0x4957e1e1f218eb4f0fD12Af5f94573E3EC799285 \
  src/EscrowService.sol:EscrowService \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 05-escrow-service

sleep 3

# Contract 6: DAOVoting
echo "Verifying DAOVoting..."
forge verify-contract 0xA9D811e31Aa66460C17b812fA625b79273c58668 \
  src/DAOVoting.sol:DAOVoting \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 06-dao-voting

sleep 3

# Contract 7: NFTMarketplace
echo "Verifying NFTMarketplace..."
forge verify-contract 0xDCEdc185f7caB8E21861C24909Cc327f1fd2Bb0d \
  src/NFTMarketplace.sol:NFTMarketplace \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 07-nft-marketplace

sleep 3

# Contract 7b: SimpleNFT
echo "Verifying SimpleNFT..."
forge verify-contract 0x3D0Bde73fb1AeC16E097Bb0aBA405aaD8F346473 \
  src/NFTMarketplace.sol:SimpleNFT \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 07-nft-marketplace

sleep 3

# Contract 8: SubscriptionService
echo "Verifying SubscriptionService..."
forge verify-contract 0x81c8d55A3B0ed4e37E90a984a4340582B4330d25 \
  src/SubscriptionService.sol:SubscriptionService \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 08-subscription-service

sleep 3

# Contract 9: Crowdfunding
echo "Verifying Crowdfunding..."
forge verify-contract 0xFeC7d44afd2fED73c55d85353D6d9727f623E7D1 \
  src/Crowdfunding.sol:Crowdfunding \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 09-crowdfunding

sleep 3

# Contract 10: MultiSigWallet
echo "Verifying MultiSigWallet..."
forge verify-contract 0x42e0F0d5f7f3903C52B4dAF27f358e6b259FCf2b \
  src/MultiSigWallet.sol:MultiSigWallet \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 10-multisig-wallet

sleep 3

# Contract 11: TokenVesting
echo "Verifying TokenVesting..."
forge verify-contract 0xEAF919E1E12B40709Ef5Cf6B10fF9Cb838b56CC5 \
  src/TokenVesting.sol:TokenVesting \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 11-token-vesting

sleep 3

# Contract 12: TimeCapsule
echo "Verifying TimeCapsule..."
forge verify-contract 0x387862150b9285325f1489Ac14f8fe933472A6B3 \
  src/TimeCapsule.sol:TimeCapsule \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 12-time-capsule

sleep 3

# Contract 13: PredictionMarket
echo "Verifying PredictionMarket..."
forge verify-contract 0x3A775022c593898b7D3b324D54f1F572aB92Cc8E \
  src/PredictionMarket.sol:PredictionMarket \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 13-prediction-market

sleep 3

# Contract 14: SkillRegistry
echo "Verifying SkillRegistry..."
forge verify-contract 0xc1700E821BF2AA6132f93241e0e2F5e1eb85A20E \
  src/SkillRegistry.sol:SkillRegistry \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 14-skill-registry

sleep 3

# Contract 15: TipJar
echo "Verifying TipJar..."
forge verify-contract 0x2da0E5Dd36756BEA7E21dfD5d8e8b224B2FAABae \
  src/TipJar.sol:TipJar \
  --chain-id 8453 --etherscan-api-key $BASESCAN_API_KEY \
  --compiler-version 0.8.24 --root 15-tip-jar

echo "✅ All contracts submitted for verification!"
echo "Check status on BaseScan in a few minutes."

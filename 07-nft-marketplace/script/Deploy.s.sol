// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/NFTMarketplace.sol";

contract DeployNFTMarketplace is Script {
    function run() external returns (NFTMarketplace, SimpleNFT) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SimpleNFT nft = new SimpleNFT();
        NFTMarketplace marketplace = new NFTMarketplace();
        vm.stopBroadcast();
        console.log("NFTMarketplace deployed to:", address(marketplace));
        console.log("SimpleNFT deployed to:", address(nft));
        return (marketplace, nft);
    }
}

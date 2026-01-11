// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/NFTBadges.sol";

contract DeployNFTBadges is Script {
    function run() external returns (NFTBadges) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        NFTBadges badges = new NFTBadges();
        
        vm.stopBroadcast();
        console.log("NFTBadges deployed to:", address(badges));
        return badges;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/SubscriptionService.sol";

contract DeploySubscriptionService is Script {
    function run() external returns (SubscriptionService) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SubscriptionService sub = new SubscriptionService();
        vm.stopBroadcast();
        console.log("SubscriptionService deployed to:", address(sub));
        return sub;
    }
}

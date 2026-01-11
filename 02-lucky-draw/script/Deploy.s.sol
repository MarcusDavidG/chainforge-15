// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/LuckyDraw.sol";

contract DeployLuckyDraw is Script {
    function run() external returns (LuckyDraw) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        LuckyDraw lottery = new LuckyDraw();
        
        vm.stopBroadcast();
        console.log("LuckyDraw deployed to:", address(lottery));
        return lottery;
    }
}

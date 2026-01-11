// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Script.sol";
import "../src/TimeCapsule.sol";
contract DeployTimeCapsule is Script {
    function run() external returns (TimeCapsule) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        TimeCapsule capsule = new TimeCapsule();
        vm.stopBroadcast();
        console.log("TimeCapsule deployed to:", address(capsule));
        return capsule;
    }
}

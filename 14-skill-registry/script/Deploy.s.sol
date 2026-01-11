// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Script.sol";
import "../src/SkillRegistry.sol";
contract DeploySkillRegistry is Script {
    function run() external returns (SkillRegistry) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SkillRegistry registry = new SkillRegistry();
        vm.stopBroadcast();
        console.log("SkillRegistry deployed to:", address(registry));
        return registry;
    }
}

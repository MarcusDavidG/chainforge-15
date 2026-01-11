// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Script.sol";
import "../src/TipJar.sol";
contract DeployTipJar is Script {
    function run() external returns (TipJar) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        TipJar jar = new TipJar();
        vm.stopBroadcast();
        console.log("TipJar deployed to:", address(jar));
        return jar;
    }
}

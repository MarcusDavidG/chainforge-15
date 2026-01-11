// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Script.sol";
import "../src/PredictionMarket.sol";
contract DeployPredictionMarket is Script {
    function run() external returns (PredictionMarket) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        PredictionMarket pm = new PredictionMarket();
        vm.stopBroadcast();
        console.log("PredictionMarket deployed to:", address(pm));
        return pm;
    }
}

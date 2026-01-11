// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/TokenFaucet.sol";

contract DeployTokenFaucet is Script {
    function run() external returns (TokenFaucet) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        TokenFaucet faucet = new TokenFaucet();
        
        vm.stopBroadcast();
        console.log("TokenFaucet deployed to:", address(faucet));
        console.log("Token address:", address(faucet.token()));
        return faucet;
    }
}

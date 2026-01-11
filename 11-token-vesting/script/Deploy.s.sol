// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Script.sol";
import "../src/TokenVesting.sol";
contract DeployTokenVesting is Script {
    function run() external returns (TokenVesting) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        TokenVesting vesting = new TokenVesting(tokenAddress);
        vm.stopBroadcast();
        console.log("TokenVesting deployed to:", address(vesting));
        return vesting;
    }
}

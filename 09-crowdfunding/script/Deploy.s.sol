// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Script.sol";
import "../src/Crowdfunding.sol";
contract DeployCrowdfunding is Script {
    function run() external returns (Crowdfunding) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        Crowdfunding cf = new Crowdfunding();
        vm.stopBroadcast();
        console.log("Crowdfunding deployed to:", address(cf));
        return cf;
    }
}

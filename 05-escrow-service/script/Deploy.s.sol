// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/EscrowService.sol";

contract DeployEscrowService is Script {
    function run() external returns (EscrowService) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        EscrowService escrow = new EscrowService();
        vm.stopBroadcast();
        console.log("EscrowService deployed to:", address(escrow));
        return escrow;
    }
}

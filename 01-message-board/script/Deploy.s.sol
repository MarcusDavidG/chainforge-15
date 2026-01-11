// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/MessageBoard.sol";

contract DeployMessageBoard is Script {
    function run() external returns (MessageBoard) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        MessageBoard board = new MessageBoard();
        
        vm.stopBroadcast();
        
        console.log("MessageBoard deployed to:", address(board));
        
        return board;
    }
}

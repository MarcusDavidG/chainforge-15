// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/DAOVoting.sol";

contract DeployDAOVoting is Script {
    function run() external returns (DAOVoting) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        DAOVoting dao = new DAOVoting();
        vm.stopBroadcast();
        console.log("DAOVoting deployed to:", address(dao));
        return dao;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Script.sol";
import "../src/MultiSigWallet.sol";
contract DeployMultiSigWallet is Script {
    function run() external returns (MultiSigWallet) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);
        address[] memory owners = new address[](3);
        owners[0] = deployer;
        owners[1] = address(0x1);
        owners[2] = address(0x2);
        MultiSigWallet wallet = new MultiSigWallet(owners, 2);
        vm.stopBroadcast();
        console.log("MultiSigWallet deployed to:", address(wallet));
        return wallet;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/TokenFaucet.sol";

contract TokenFaucetTest is Test {
    TokenFaucet public faucet;
    address public user = address(0x1);

    function setUp() public {
        faucet = new TokenFaucet();
    }

    function testClaim() public {
        vm.prank(user);
        faucet.claim();
        
        assertEq(faucet.token().balanceOf(user), 100 * 10**18);
    }

    function testCannotClaimDuringCooldown() public {
        vm.startPrank(user);
        faucet.claim();
        
        vm.expectRevert("Cooldown active");
        faucet.claim();
        vm.stopPrank();
    }

    function testClaimAfterCooldown() public {
        vm.startPrank(user);
        faucet.claim();
        
        vm.warp(block.timestamp + 24 hours);
        faucet.claim();
        
        assertEq(faucet.token().balanceOf(user), 200 * 10**18);
        vm.stopPrank();
    }
}

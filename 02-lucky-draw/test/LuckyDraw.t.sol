// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/LuckyDraw.sol";

contract LuckyDrawTest is Test {
    LuckyDraw public lottery;
    address public user1 = address(0x1);
    address public user2 = address(0x2);
    address public user3 = address(0x3);

    function setUp() public {
        lottery = new LuckyDraw();
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
        vm.deal(user3, 10 ether);
    }

    function testCreateDraw() public {
        uint256 drawId = lottery.createDraw(0.01 ether, 1 days);
        assertEq(drawId, 0);
        assertEq(lottery.getDrawCount(), 1);
    }

    function testBuyTicket() public {
        lottery.createDraw(0.01 ether, 1 days);
        
        vm.prank(user1);
        lottery.buyTicket{value: 0.01 ether}(0);
        
        (,, uint256 participantCount,,,) = lottery.getDrawDetails(0);
        assertEq(participantCount, 1);
    }

    function testSelectWinner() public {
        lottery.createDraw(0.01 ether, 1 hours);
        
        vm.prank(user1);
        lottery.buyTicket{value: 0.01 ether}(0);
        vm.prank(user2);
        lottery.buyTicket{value: 0.01 ether}(0);
        vm.prank(user3);
        lottery.buyTicket{value: 0.01 ether}(0);
        
        vm.warp(block.timestamp + 2 hours);
        
        lottery.selectWinner(0);
        
        (,,, address winner, bool finalized,) = lottery.getDrawDetails(0);
        assertTrue(finalized);
        assertTrue(winner != address(0));
    }

    function testCannotBuyAfterEnd() public {
        lottery.createDraw(0.01 ether, 1 hours);
        
        vm.warp(block.timestamp + 2 hours);
        
        vm.prank(user1);
        vm.expectRevert("Draw ended");
        lottery.buyTicket{value: 0.01 ether}(0);
    }
}

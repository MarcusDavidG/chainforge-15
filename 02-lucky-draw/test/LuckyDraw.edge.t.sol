// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/LuckyDraw.sol";

contract LuckyDrawEdgeCaseTest is Test {
    LuckyDraw public lottery;
    address public user1 = address(0x1);

    function setUp() public {
        lottery = new LuckyDraw();
        vm.deal(user1, 10 ether);
    }

    function testCreateDrawInvalidPrice() public {
        vm.expectRevert("Invalid ticket price");
        lottery.createDraw(0, 1 days);
    }

    function testCreateDrawInvalidDuration() public {
        vm.expectRevert("Invalid duration");
        lottery.createDraw(0.01 ether, 0);
    }

    function testBuyTicketWrongPrice() public {
        lottery.createDraw(0.01 ether, 1 hours);
        
        vm.prank(user1);
        vm.expectRevert("Incorrect ticket price");
        lottery.buyTicket{value: 0.02 ether}(0);
    }

    function testSelectWinnerBeforeEnd() public {
        lottery.createDraw(0.01 ether, 1 hours);
        
        vm.prank(user1);
        lottery.buyTicket{value: 0.01 ether}(0);
        
        vm.expectRevert("Draw not ended");
        lottery.selectWinner(0);
    }

    function testSelectWinnerNoParticipants() public {
        lottery.createDraw(0.01 ether, 1 hours);
        
        vm.warp(block.timestamp + 2 hours);
        
        vm.expectRevert("No participants");
        lottery.selectWinner(0);
    }

    function testSetOwnerFeeTooHigh() public {
        vm.expectRevert("Fee too high");
        lottery.setOwnerFee(25);
    }

    function testBuyTicketInvalidDraw() public {
        vm.prank(user1);
        vm.expectRevert("Invalid draw ID");
        lottery.buyTicket{value: 0.01 ether}(999);
    }
}

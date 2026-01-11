// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/MessageBoard.sol";

contract MessageBoardTest is Test {
    MessageBoard public board;
    address public user1 = address(0x1);
    address public user2 = address(0x2);

    function setUp() public {
        board = new MessageBoard();
        vm.deal(user1, 1 ether);
        vm.deal(user2, 1 ether);
    }

    function testPostMessage() public {
        vm.prank(user1);
        uint256 messageId = board.postMessage{value: 0.0001 ether}("Hello World", 0);
        
        assertEq(messageId, 0);
        assertEq(board.getMessageCount(), 1);
        
        (address author, string memory content, , uint256 category, bool edited) = board.getMessage(0);
        assertEq(author, user1);
        assertEq(content, "Hello World");
        assertEq(category, 0);
        assertFalse(edited);
    }

    function testPostMessageInsufficientFee() public {
        vm.prank(user1);
        vm.expectRevert("Insufficient fee");
        board.postMessage{value: 0.00001 ether}("Hello", 0);
    }

    function testEditMessage() public {
        vm.prank(user1);
        uint256 messageId = board.postMessage{value: 0.0001 ether}("Original", 0);
        
        vm.prank(user1);
        board.editMessage(messageId, "Edited");
        
        (, string memory content, , , bool edited) = board.getMessage(messageId);
        assertEq(content, "Edited");
        assertTrue(edited);
    }

    function testEditMessageUnauthorized() public {
        vm.prank(user1);
        uint256 messageId = board.postMessage{value: 0.0001 ether}("Original", 0);
        
        vm.prank(user2);
        vm.expectRevert("Not message author");
        board.editMessage(messageId, "Hacked");
    }

    function testGetMessagesByCategory() public {
        vm.prank(user1);
        board.postMessage{value: 0.0001 ether}("Cat 0", 0);
        board.postMessage{value: 0.0001 ether}("Cat 1", 1);
        board.postMessage{value: 0.0001 ether}("Cat 0 again", 0);
        
        uint256[] memory cat0 = board.getMessagesByCategory(0);
        assertEq(cat0.length, 2);
        assertEq(cat0[0], 0);
        assertEq(cat0[1], 2);
    }

    function testWithdraw() public {
        vm.prank(user1);
        board.postMessage{value: 0.0001 ether}("Test", 0);
        
        uint256 balanceBefore = address(this).balance;
        board.withdraw();
        
        assertEq(address(board).balance, 0);
    }
}

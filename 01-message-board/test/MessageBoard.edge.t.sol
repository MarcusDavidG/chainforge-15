// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/MessageBoard.sol";

contract MessageBoardEdgeCaseTest is Test {
    MessageBoard public board;
    address public owner;
    address public user1 = address(0x1);

    function setUp() public {
        board = new MessageBoard();
        owner = address(this);
        vm.deal(user1, 10 ether);
    }

    function testPostEmptyMessage() public {
        vm.prank(user1);
        vm.expectRevert("Empty message");
        board.postMessage{value: 0.0001 ether}("", 0);
    }

    function testPostTooLongMessage() public {
        string memory longMessage = new string(501);
        vm.prank(user1);
        vm.expectRevert("Message too long");
        board.postMessage{value: 0.0001 ether}(longMessage, 0);
    }

    function testEditNonExistentMessage() public {
        vm.prank(user1);
        vm.expectRevert("Invalid message ID");
        board.editMessage(999, "New content");
    }

    function testGetNonExistentMessage() public {
        vm.expectRevert("Invalid message ID");
        board.getMessage(999);
    }

    function testWithdrawByNonOwner() public {
        vm.prank(user1);
        board.postMessage{value: 0.0001 ether}("Test", 0);
        
        vm.prank(user1);
        vm.expectRevert("Not owner");
        board.withdraw();
    }

    function testSetFeeByNonOwner() public {
        vm.prank(user1);
        vm.expectRevert("Not owner");
        board.setPostFee(0.001 ether);
    }

    function testMultipleMessagesInCategory() public {
        vm.startPrank(user1);
        board.postMessage{value: 0.0001 ether}("Message 1", 1);
        board.postMessage{value: 0.0001 ether}("Message 2", 1);
        board.postMessage{value: 0.0001 ether}("Message 3", 2);
        vm.stopPrank();

        uint256[] memory cat1 = board.getMessagesByCategory(1);
        assertEq(cat1.length, 2);
    }

    function testZeroFeePosting() public {
        board.setPostFee(0);
        
        vm.prank(user1);
        board.postMessage("Free post", 0);
        
        assertEq(board.getMessageCount(), 1);
    }
}

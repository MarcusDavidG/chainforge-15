// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/NFTBadges.sol";

contract NFTBadgesEdgeCaseTest is Test {
    NFTBadges public badges;
    address public user1 = address(0x1);
    address public user2 = address(0x2);

    function setUp() public {
        badges = new NFTBadges();
    }

    function testMintToZeroAddress() public {
        vm.expectRevert();
        badges.mintBadge(address(0), "Badge", "Description", "ipfs://", 1);
    }

    function testGetNonExistentBadge() public {
        vm.expectRevert("Badge does not exist");
        badges.getBadge(999);
    }

    function testBatchMintEmptyArray() public {
        address[] memory recipients = new address[](0);
        badges.batchMintBadge(recipients, "Badge", "Desc", "ipfs://", 1);
        assertEq(badges.nextTokenId(), 1);
    }

    function testTransferBadgeUpdatesUserBadges() public {
        badges.mintBadge(user1, "Badge1", "Desc", "ipfs://", 1);
        badges.mintBadge(user1, "Badge2", "Desc", "ipfs://", 2);
        
        assertEq(badges.getUserBadgeCount(user1), 2);
        
        vm.prank(user1);
        badges.transferFrom(user1, user2, 1);
        
        assertEq(badges.getUserBadgeCount(user1), 1);
        assertEq(badges.getUserBadgeCount(user2), 1);
    }

    function testGetUserBadgesEmptyArray() public {
        uint256[] memory userBadges = badges.getUserBadges(user1);
        assertEq(userBadges.length, 0);
    }
}

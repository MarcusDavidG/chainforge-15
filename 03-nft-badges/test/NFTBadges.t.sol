// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/NFTBadges.sol";

contract NFTBadgesTest is Test {
    NFTBadges public badges;
    address public user1 = address(0x1);
    address public user2 = address(0x2);

    function setUp() public {
        badges = new NFTBadges();
    }

    function testMintBadge() public {
        uint256 tokenId = badges.mintBadge(user1, "First Post", "Made your first post", "ipfs://...", 1);
        
        assertEq(tokenId, 1);
        assertEq(badges.ownerOf(tokenId), user1);
        assertEq(badges.getUserBadgeCount(user1), 1);
    }

    function testGetBadgeDetails() public {
        badges.mintBadge(user1, "First Post", "Made your first post", "ipfs://test", 1);
        
        (string memory name, string memory desc, string memory uri, uint256 milestone, , address owner_) = badges.getBadge(1);
        assertEq(name, "First Post");
        assertEq(desc, "Made your first post");
        assertEq(uri, "ipfs://test");
        assertEq(milestone, 1);
        assertEq(owner_, user1);
    }

    function testBatchMint() public {
        address[] memory recipients = new address[](3);
        recipients[0] = user1;
        recipients[1] = user2;
        recipients[2] = address(0x3);
        
        badges.batchMintBadge(recipients, "Early Adopter", "Joined early", "ipfs://early", 100);
        
        assertEq(badges.getUserBadgeCount(user1), 1);
        assertEq(badges.getUserBadgeCount(user2), 1);
        assertEq(badges.getUserBadgeCount(address(0x3)), 1);
    }

    function testTransferUpdatesMapping() public {
        badges.mintBadge(user1, "Test", "Test badge", "ipfs://", 1);
        
        vm.prank(user1);
        badges.transferFrom(user1, user2, 1);
        
        assertEq(badges.getUserBadgeCount(user1), 0);
        assertEq(badges.getUserBadgeCount(user2), 1);
    }
}

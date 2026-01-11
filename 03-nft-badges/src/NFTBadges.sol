// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTBadges is ERC721, Ownable {
    struct Badge {
        string name;
        string description;
        string imageURI;
        uint256 milestone;
        uint256 mintedAt;
    }

    mapping(uint256 => Badge) public badges;
    mapping(address => uint256[]) public userBadges;
    
    uint256 public nextTokenId = 1;
    string private _baseTokenURI;

    event BadgeMinted(uint256 indexed tokenId, address indexed recipient, string name, uint256 milestone);

    constructor() ERC721("ChainForge Badges", "CFB") Ownable(msg.sender) {}

    function mintBadge(
        address _recipient,
        string memory _name,
        string memory _description,
        string memory _imageURI,
        uint256 _milestone
    ) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId++;

        _safeMint(_recipient, tokenId);

        badges[tokenId] = Badge({
            name: _name,
            description: _description,
            imageURI: _imageURI,
            milestone: _milestone,
            mintedAt: block.timestamp
        });

        userBadges[_recipient].push(tokenId);

        emit BadgeMinted(tokenId, _recipient, _name, _milestone);

        return tokenId;
    }

    function batchMintBadge(
        address[] memory _recipients,
        string memory _name,
        string memory _description,
        string memory _imageURI,
        uint256 _milestone
    ) external onlyOwner {
        for (uint256 i = 0; i < _recipients.length; i++) {
            mintBadge(_recipients[i], _name, _description, _imageURI, _milestone);
        }
    }

    function getBadge(uint256 _tokenId) external view returns (
        string memory name,
        string memory description,
        string memory imageURI,
        uint256 milestone,
        uint256 mintedAt,
        address owner_
    ) {
        require(_ownerOf(_tokenId) != address(0), "Badge does not exist");
        Badge memory badge = badges[_tokenId];
        return (
            badge.name,
            badge.description,
            badge.imageURI,
            badge.milestone,
            badge.mintedAt,
            ownerOf(_tokenId)
        );
    }

    function getUserBadges(address _user) external view returns (uint256[] memory) {
        return userBadges[_user];
    }

    function getUserBadgeCount(address _user) external view returns (uint256) {
        return userBadges[_user].length;
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function _update(address to, uint256 tokenId, address auth) internal override returns (address) {
        address from = _ownerOf(tokenId);
        
        // Update userBadges mapping when transferring
        if (from != address(0) && to != address(0) && from != to) {
            // Remove from old owner
            uint256[] storage fromBadges = userBadges[from];
            for (uint256 i = 0; i < fromBadges.length; i++) {
                if (fromBadges[i] == tokenId) {
                    fromBadges[i] = fromBadges[fromBadges.length - 1];
                    fromBadges.pop();
                    break;
                }
            }
            
            // Add to new owner
            userBadges[to].push(tokenId);
        }
        
        return super._update(to, tokenId, auth);
    }
}

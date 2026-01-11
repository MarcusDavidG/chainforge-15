// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SimpleNFT is ERC721 {
    uint256 public nextTokenId;
    constructor() ERC721("Marketplace NFT", "MNFT") {}
    function mint() external returns (uint256) {
        uint256 tokenId = nextTokenId++;
        _mint(msg.sender, tokenId);
        return tokenId;
    }
}

contract NFTMarketplace {
    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
        bool active;
    }
    
    mapping(uint256 => Listing) public listings;
    uint256 public listingCount;
    uint256 public feePercent = 25; // 2.5%
    address public owner;
    
    event Listed(uint256 indexed listingId, address indexed seller, address nftContract, uint256 tokenId, uint256 price);
    event Sold(uint256 indexed listingId, address indexed buyer, uint256 price);
    
    constructor() {
        owner = msg.sender;
    }
    
    function list(address _nftContract, uint256 _tokenId, uint256 _price) external returns (uint256) {
        require(_price > 0, "Price must be > 0");
        IERC721 nft = IERC721(_nftContract);
        require(nft.ownerOf(_tokenId) == msg.sender, "Not token owner");
        require(nft.getApproved(_tokenId) == address(this) || nft.isApprovedForAll(msg.sender, address(this)), "Not approved");
        
        uint256 listingId = listingCount++;
        listings[listingId] = Listing({
            seller: msg.sender,
            nftContract: _nftContract,
            tokenId: _tokenId,
            price: _price,
            active: true
        });
        
        emit Listed(listingId, msg.sender, _nftContract, _tokenId, _price);
        return listingId;
    }
    
    function buy(uint256 _listingId) external payable {
        Listing storage listing = listings[_listingId];
        require(listing.active, "Not active");
        require(msg.value == listing.price, "Wrong price");
        
        listing.active = false;
        
        uint256 fee = (listing.price * feePercent) / 1000;
        uint256 sellerAmount = listing.price - fee;
        
        IERC721(listing.nftContract).safeTransferFrom(listing.seller, msg.sender, listing.tokenId);
        payable(listing.seller).transfer(sellerAmount);
        payable(owner).transfer(fee);
        
        emit Sold(_listingId, msg.sender, listing.price);
    }
    
    function cancel(uint256 _listingId) external {
        Listing storage listing = listings[_listingId];
        require(listing.active, "Not active");
        require(msg.sender == listing.seller, "Not seller");
        listing.active = false;
    }
}

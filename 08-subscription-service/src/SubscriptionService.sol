// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SubscriptionService {
    struct Subscription {
        uint256 price;
        uint256 duration;
        uint256 expiresAt;
        bool active;
    }
    
    mapping(address => Subscription) public subscriptions;
    address public owner;
    uint256 public monthlyPrice = 0.01 ether;
    uint256 public monthDuration = 30 days;
    
    event Subscribed(address indexed user, uint256 expiresAt);
    event Renewed(address indexed user, uint256 newExpiry);
    
    constructor() {
        owner = msg.sender;
    }
    
    function subscribe() external payable {
        require(msg.value >= monthlyPrice, "Insufficient payment");
        
        Subscription storage sub = subscriptions[msg.sender];
        uint256 startTime = sub.expiresAt > block.timestamp ? sub.expiresAt : block.timestamp;
        
        sub.price = monthlyPrice;
        sub.duration = monthDuration;
        sub.expiresAt = startTime + monthDuration;
        sub.active = true;
        
        emit Subscribed(msg.sender, sub.expiresAt);
    }
    
    function isActive(address _user) external view returns (bool) {
        return subscriptions[_user].active && subscriptions[_user].expiresAt > block.timestamp;
    }
    
    function setPrice(uint256 _price) external {
        require(msg.sender == owner, "Only owner");
        monthlyPrice = _price;
    }
    
    function withdraw() external {
        require(msg.sender == owner, "Only owner");
        payable(owner).transfer(address(this).balance);
    }
}

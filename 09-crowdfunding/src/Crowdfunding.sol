// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Crowdfunding {
    struct Campaign {
        address creator;
        uint256 goal;
        uint256 pledged;
        uint256 deadline;
        bool claimed;
        mapping(address => uint256) pledges;
    }
    
    mapping(uint256 => Campaign) public campaigns;
    uint256 public campaignCount;
    
    event CampaignCreated(uint256 indexed campaignId, address indexed creator, uint256 goal, uint256 deadline);
    event Pledged(uint256 indexed campaignId, address indexed pledger, uint256 amount);
    event Claimed(uint256 indexed campaignId, uint256 amount);
    event Refunded(uint256 indexed campaignId, address indexed pledger, uint256 amount);
    
    function createCampaign(uint256 _goal, uint256 _duration) external returns (uint256) {
        require(_goal > 0, "Goal must be > 0");
        require(_duration > 0, "Duration must be > 0");
        
        uint256 campaignId = campaignCount++;
        Campaign storage campaign = campaigns[campaignId];
        campaign.creator = msg.sender;
        campaign.goal = _goal;
        campaign.deadline = block.timestamp + _duration;
        
        emit CampaignCreated(campaignId, msg.sender, _goal, campaign.deadline);
        return campaignId;
    }
    
    function pledge(uint256 _campaignId) external payable {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp < campaign.deadline, "Campaign ended");
        require(msg.value > 0, "Amount must be > 0");
        
        campaign.pledges[msg.sender] += msg.value;
        campaign.pledged += msg.value;
        
        emit Pledged(_campaignId, msg.sender, msg.value);
    }
    
    function claim(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];
        require(msg.sender == campaign.creator, "Not creator");
        require(block.timestamp >= campaign.deadline, "Not ended");
        require(campaign.pledged >= campaign.goal, "Goal not reached");
        require(!campaign.claimed, "Already claimed");
        
        campaign.claimed = true;
        payable(campaign.creator).transfer(campaign.pledged);
        
        emit Claimed(_campaignId, campaign.pledged);
    }
    
    function refund(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp >= campaign.deadline, "Not ended");
        require(campaign.pledged < campaign.goal, "Goal reached");
        
        uint256 amount = campaign.pledges[msg.sender];
        require(amount > 0, "No pledge");
        
        campaign.pledges[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        
        emit Refunded(_campaignId, msg.sender, amount);
    }
    
    function getCampaignInfo(uint256 _campaignId) external view returns (
        address creator,
        uint256 goal,
        uint256 pledged,
        uint256 deadline,
        bool claimed
    ) {
        Campaign storage campaign = campaigns[_campaignId];
        return (campaign.creator, campaign.goal, campaign.pledged, campaign.deadline, campaign.claimed);
    }
}

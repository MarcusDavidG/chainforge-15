// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract PredictionMarket {
    enum Outcome { Pending, Yes, No }
    
    struct Market {
        string question;
        uint256 endTime;
        Outcome outcome;
        uint256 yesPool;
        uint256 noPool;
        mapping(address => uint256) yesBets;
        mapping(address => uint256) noBets;
        mapping(address => bool) claimed;
        address creator;
    }
    
    mapping(uint256 => Market) public markets;
    uint256 public marketCount;
    
    event MarketCreated(uint256 indexed marketId, string question, uint256 endTime);
    event BetPlaced(uint256 indexed marketId, address indexed better, bool prediction, uint256 amount);
    event MarketResolved(uint256 indexed marketId, Outcome outcome);
    event Claimed(uint256 indexed marketId, address indexed winner, uint256 amount);
    
    function createMarket(string memory _question, uint256 _duration) external returns (uint256) {
        uint256 marketId = marketCount++;
        Market storage market = markets[marketId];
        market.question = _question;
        market.endTime = block.timestamp + _duration;
        market.outcome = Outcome.Pending;
        market.creator = msg.sender;
        
        emit MarketCreated(marketId, _question, market.endTime);
        return marketId;
    }
    
    function bet(uint256 _marketId, bool _prediction) external payable {
        Market storage market = markets[_marketId];
        require(block.timestamp < market.endTime, "Market ended");
        require(market.outcome == Outcome.Pending, "Market resolved");
        require(msg.value > 0, "Must bet something");
        
        if (_prediction) {
            market.yesBets[msg.sender] += msg.value;
            market.yesPool += msg.value;
        } else {
            market.noBets[msg.sender] += msg.value;
            market.noPool += msg.value;
        }
        
        emit BetPlaced(_marketId, msg.sender, _prediction, msg.value);
    }
    
    function resolve(uint256 _marketId, bool _outcome) external {
        Market storage market = markets[_marketId];
        require(msg.sender == market.creator, "Only creator");
        require(block.timestamp >= market.endTime, "Not ended");
        require(market.outcome == Outcome.Pending, "Already resolved");
        
        market.outcome = _outcome ? Outcome.Yes : Outcome.No;
        
        emit MarketResolved(_marketId, market.outcome);
    }
    
    function claim(uint256 _marketId) external {
        Market storage market = markets[_marketId];
        require(market.outcome != Outcome.Pending, "Not resolved");
        require(!market.claimed[msg.sender], "Already claimed");
        
        uint256 winnings = 0;
        uint256 totalPool = market.yesPool + market.noPool;
        
        if (market.outcome == Outcome.Yes && market.yesBets[msg.sender] > 0) {
            winnings = (market.yesBets[msg.sender] * totalPool) / market.yesPool;
        } else if (market.outcome == Outcome.No && market.noBets[msg.sender] > 0) {
            winnings = (market.noBets[msg.sender] * totalPool) / market.noPool;
        }
        
        require(winnings > 0, "No winnings");
        
        market.claimed[msg.sender] = true;
        payable(msg.sender).transfer(winnings);
        
        emit Claimed(_marketId, msg.sender, winnings);
    }
    
    function getMarketInfo(uint256 _marketId) external view returns (
        string memory question,
        uint256 endTime,
        Outcome outcome,
        uint256 yesPool,
        uint256 noPool
    ) {
        Market storage market = markets[_marketId];
        return (market.question, market.endTime, market.outcome, market.yesPool, market.noPool);
    }
}

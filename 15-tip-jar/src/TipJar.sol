// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TipJar {
    struct Tip {
        address tipper;
        uint256 amount;
        string message;
        uint256 timestamp;
    }
    
    mapping(address => Tip[]) public creatorTips;
    mapping(address => uint256) public totalTips;
    
    event TipReceived(address indexed creator, address indexed tipper, uint256 amount, string message);
    event Withdrawn(address indexed creator, uint256 amount);
    
    function tip(address _creator, string memory _message) external payable {
        require(msg.value > 0, "Must send tip");
        require(_creator != address(0), "Invalid creator");
        
        creatorTips[_creator].push(Tip({
            tipper: msg.sender,
            amount: msg.value,
            message: _message,
            timestamp: block.timestamp
        }));
        
        totalTips[_creator] += msg.value;
        
        emit TipReceived(_creator, msg.sender, msg.value, _message);
    }
    
    function withdraw() external {
        uint256 amount = totalTips[msg.sender];
        require(amount > 0, "No tips");
        
        totalTips[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        
        emit Withdrawn(msg.sender, amount);
    }
    
    function getTips(address _creator) external view returns (Tip[] memory) {
        return creatorTips[_creator];
    }
    
    function getTipCount(address _creator) external view returns (uint256) {
        return creatorTips[_creator].length;
    }
    
    function getLeaderboard(address[] memory _creators) external view returns (address[] memory, uint256[] memory) {
        uint256[] memory amounts = new uint256[](_creators.length);
        
        for (uint256 i = 0; i < _creators.length; i++) {
            amounts[i] = totalTips[_creators[i]];
        }
        
        // Simple bubble sort for demo (not gas efficient for many creators)
        for (uint256 i = 0; i < _creators.length; i++) {
            for (uint256 j = i + 1; j < _creators.length; j++) {
                if (amounts[j] > amounts[i]) {
                    // Swap amounts
                    uint256 tempAmount = amounts[i];
                    amounts[i] = amounts[j];
                    amounts[j] = tempAmount;
                    
                    // Swap addresses
                    address tempAddr = _creators[i];
                    _creators[i] = _creators[j];
                    _creators[j] = tempAddr;
                }
            }
        }
        
        return (_creators, amounts);
    }
}

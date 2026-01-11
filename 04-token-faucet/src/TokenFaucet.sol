// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FaucetToken is ERC20, Ownable {
    constructor() ERC20("Faucet Token", "FTKN") Ownable(msg.sender) {
        _mint(address(this), 1000000 * 10**decimals());
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}

contract TokenFaucet {
    FaucetToken public token;
    uint256 public claimAmount = 100 * 10**18;
    uint256 public cooldownTime = 24 hours;
    
    mapping(address => uint256) public lastClaim;
    
    event TokensClaimed(address indexed claimer, uint256 amount);

    constructor() {
        token = new FaucetToken();
    }

    function claim() external {
        require(block.timestamp >= lastClaim[msg.sender] + cooldownTime, "Cooldown active");
        require(token.balanceOf(address(this)) >= claimAmount, "Faucet empty");
        
        lastClaim[msg.sender] = block.timestamp;
        token.transfer(msg.sender, claimAmount);
        
        emit TokensClaimed(msg.sender, claimAmount);
    }

    function getTimeUntilNextClaim(address _user) external view returns (uint256) {
        if (block.timestamp >= lastClaim[_user] + cooldownTime) {
            return 0;
        }
        return (lastClaim[_user] + cooldownTime) - block.timestamp;
    }

    function setClaimAmount(uint256 _amount) external {
        require(msg.sender == token.owner(), "Not owner");
        claimAmount = _amount;
    }

    function setCooldown(uint256 _cooldown) external {
        require(msg.sender == token.owner(), "Not owner");
        cooldownTime = _cooldown;
    }

    function refill(uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenVesting {
    struct VestingSchedule {
        uint256 totalAmount;
        uint256 startTime;
        uint256 cliffDuration;
        uint256 duration;
        uint256 released;
        bool revocable;
        bool revoked;
    }
    
    IERC20 public token;
    mapping(address => VestingSchedule) public schedules;
    address public owner;
    
    event VestingCreated(address indexed beneficiary, uint256 amount, uint256 duration);
    event TokensReleased(address indexed beneficiary, uint256 amount);
    event VestingRevoked(address indexed beneficiary);
    
    constructor(address _token) {
        token = IERC20(_token);
        owner = msg.sender;
    }
    
    function createVesting(
        address _beneficiary,
        uint256 _amount,
        uint256 _cliffDuration,
        uint256 _duration,
        bool _revocable
    ) external {
        require(msg.sender == owner, "Only owner");
        require(schedules[_beneficiary].totalAmount == 0, "Schedule exists");
        require(_amount > 0, "Amount must be > 0");
        
        schedules[_beneficiary] = VestingSchedule({
            totalAmount: _amount,
            startTime: block.timestamp,
            cliffDuration: _cliffDuration,
            duration: _duration,
            released: 0,
            revocable: _revocable,
            revoked: false
        });
        
        token.transferFrom(msg.sender, address(this), _amount);
        
        emit VestingCreated(_beneficiary, _amount, _duration);
    }
    
    function release() external {
        VestingSchedule storage schedule = schedules[msg.sender];
        require(schedule.totalAmount > 0, "No schedule");
        require(!schedule.revoked, "Revoked");
        
        uint256 vested = vestedAmount(msg.sender);
        uint256 releasable = vested - schedule.released;
        require(releasable > 0, "Nothing to release");
        
        schedule.released += releasable;
        token.transfer(msg.sender, releasable);
        
        emit TokensReleased(msg.sender, releasable);
    }
    
    function vestedAmount(address _beneficiary) public view returns (uint256) {
        VestingSchedule storage schedule = schedules[_beneficiary];
        
        if (block.timestamp < schedule.startTime + schedule.cliffDuration) {
            return 0;
        }
        
        if (block.timestamp >= schedule.startTime + schedule.duration) {
            return schedule.totalAmount;
        }
        
        return (schedule.totalAmount * (block.timestamp - schedule.startTime)) / schedule.duration;
    }
    
    function revoke(address _beneficiary) external {
        require(msg.sender == owner, "Only owner");
        VestingSchedule storage schedule = schedules[_beneficiary];
        require(schedule.revocable, "Not revocable");
        require(!schedule.revoked, "Already revoked");
        
        uint256 vested = vestedAmount(_beneficiary);
        uint256 refund = schedule.totalAmount - vested;
        
        schedule.revoked = true;
        
        if (refund > 0) {
            token.transfer(owner, refund);
        }
        
        emit VestingRevoked(_beneficiary);
    }
}

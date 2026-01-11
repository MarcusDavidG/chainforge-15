// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TimeCapsule {
    struct Capsule {
        address creator;
        string message;
        uint256 unlockTime;
        bool opened;
        address recipient;
    }
    
    mapping(uint256 => Capsule) public capsules;
    uint256 public capsuleCount;
    
    event CapsuleCreated(uint256 indexed capsuleId, address indexed creator, uint256 unlockTime);
    event CapsuleOpened(uint256 indexed capsuleId, address indexed opener);
    
    function createCapsule(string memory _message, uint256 _unlockTime, address _recipient) external returns (uint256) {
        require(_unlockTime > block.timestamp, "Unlock time must be future");
        require(bytes(_message).length > 0, "Message required");
        
        uint256 capsuleId = capsuleCount++;
        capsules[capsuleId] = Capsule({
            creator: msg.sender,
            message: _message,
            unlockTime: _unlockTime,
            opened: false,
            recipient: _recipient
        });
        
        emit CapsuleCreated(capsuleId, msg.sender, _unlockTime);
        return capsuleId;
    }
    
    function openCapsule(uint256 _capsuleId) external view returns (string memory) {
        require(_capsuleId < capsuleCount, "Invalid capsule");
        Capsule storage capsule = capsules[_capsuleId];
        require(block.timestamp >= capsule.unlockTime, "Not unlocked yet");
        
        if (capsule.recipient != address(0)) {
            require(msg.sender == capsule.recipient, "Not recipient");
        }
        
        return capsule.message;
    }
    
    function getTimeUntilUnlock(uint256 _capsuleId) external view returns (uint256) {
        require(_capsuleId < capsuleCount, "Invalid capsule");
        Capsule storage capsule = capsules[_capsuleId];
        
        if (block.timestamp >= capsule.unlockTime) {
            return 0;
        }
        return capsule.unlockTime - block.timestamp;
    }
}

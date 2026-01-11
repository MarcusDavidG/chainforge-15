// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SkillRegistry {
    struct Skill {
        string name;
        string description;
        address issuer;
        uint256 issuedAt;
        bool revoked;
    }
    
    struct Endorsement {
        address endorser;
        string comment;
        uint256 timestamp;
    }
    
    mapping(address => mapping(uint256 => Skill)) public userSkills;
    mapping(address => uint256) public skillCount;
    mapping(bytes32 => Endorsement[]) public endorsements;
    
    event SkillIssued(address indexed user, uint256 indexed skillId, string name, address indexed issuer);
    event SkillEndorsed(address indexed user, uint256 indexed skillId, address indexed endorser);
    event SkillRevoked(address indexed user, uint256 indexed skillId);
    
    function issueSkill(
        address _user,
        string memory _name,
        string memory _description
    ) external returns (uint256) {
        uint256 skillId = skillCount[_user]++;
        
        userSkills[_user][skillId] = Skill({
            name: _name,
            description: _description,
            issuer: msg.sender,
            issuedAt: block.timestamp,
            revoked: false
        });
        
        emit SkillIssued(_user, skillId, _name, msg.sender);
        return skillId;
    }
    
    function endorseSkill(
        address _user,
        uint256 _skillId,
        string memory _comment
    ) external {
        require(_skillId < skillCount[_user], "Invalid skill");
        require(!userSkills[_user][_skillId].revoked, "Skill revoked");
        require(msg.sender != _user, "Cannot endorse yourself");
        
        bytes32 key = keccak256(abi.encodePacked(_user, _skillId));
        endorsements[key].push(Endorsement({
            endorser: msg.sender,
            comment: _comment,
            timestamp: block.timestamp
        }));
        
        emit SkillEndorsed(_user, _skillId, msg.sender);
    }
    
    function revokeSkill(address _user, uint256 _skillId) external {
        require(_skillId < skillCount[_user], "Invalid skill");
        Skill storage skill = userSkills[_user][_skillId];
        require(msg.sender == skill.issuer, "Not issuer");
        require(!skill.revoked, "Already revoked");
        
        skill.revoked = true;
        
        emit SkillRevoked(_user, _skillId);
    }
    
    function getSkill(address _user, uint256 _skillId) external view returns (
        string memory name,
        string memory description,
        address issuer,
        uint256 issuedAt,
        bool revoked
    ) {
        require(_skillId < skillCount[_user], "Invalid skill");
        Skill memory skill = userSkills[_user][_skillId];
        return (skill.name, skill.description, skill.issuer, skill.issuedAt, skill.revoked);
    }
    
    function getEndorsements(address _user, uint256 _skillId) external view returns (Endorsement[] memory) {
        bytes32 key = keccak256(abi.encodePacked(_user, _skillId));
        return endorsements[key];
    }
}

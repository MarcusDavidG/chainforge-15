// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DAOVoting {
    struct Proposal {
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 endTime;
        bool executed;
        mapping(address => bool) hasVoted;
    }
    
    mapping(uint256 => Proposal) public proposals;
    mapping(address => uint256) public votingPower;
    uint256 public proposalCount;
    address public owner;
    
    event ProposalCreated(uint256 indexed proposalId, string description, uint256 endTime);
    event Voted(uint256 indexed proposalId, address indexed voter, bool support);
    
    constructor() {
        owner = msg.sender;
        votingPower[owner] = 100;
    }
    
    function grantVotingPower(address _voter, uint256 _power) external {
        require(msg.sender == owner, "Only owner");
        votingPower[_voter] = _power;
    }
    
    function createProposal(string memory _description, uint256 _duration) external returns (uint256) {
        require(votingPower[msg.sender] > 0, "No voting power");
        
        uint256 proposalId = proposalCount++;
        Proposal storage proposal = proposals[proposalId];
        proposal.description = _description;
        proposal.endTime = block.timestamp + _duration;
        
        emit ProposalCreated(proposalId, _description, proposal.endTime);
        return proposalId;
    }
    
    function vote(uint256 _proposalId, bool _support) external {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp < proposal.endTime, "Voting ended");
        require(!proposal.hasVoted[msg.sender], "Already voted");
        require(votingPower[msg.sender] > 0, "No voting power");
        
        proposal.hasVoted[msg.sender] = true;
        
        if (_support) {
            proposal.votesFor += votingPower[msg.sender];
        } else {
            proposal.votesAgainst += votingPower[msg.sender];
        }
        
        emit Voted(_proposalId, msg.sender, _support);
    }
    
    function getProposal(uint256 _proposalId) external view returns (
        string memory description,
        uint256 votesFor,
        uint256 votesAgainst,
        uint256 endTime,
        bool executed
    ) {
        Proposal storage proposal = proposals[_proposalId];
        return (proposal.description, proposal.votesFor, proposal.votesAgainst, proposal.endTime, proposal.executed);
    }
}

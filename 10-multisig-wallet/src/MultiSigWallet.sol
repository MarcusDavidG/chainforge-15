// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MultiSigWallet {
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
        uint256 confirmations;
    }
    
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public required;
    
    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public confirmed;
    
    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 indexed txId);
    event Confirm(uint256 indexed txId, address indexed owner);
    event Execute(uint256 indexed txId);
    
    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not owner");
        _;
    }
    
    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length > 0, "Owners required");
        require(_required > 0 && _required <= _owners.length, "Invalid required");
        
        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "Invalid owner");
            require(!isOwner[owner], "Duplicate owner");
            
            isOwner[owner] = true;
            owners.push(owner);
        }
        
        required = _required;
    }
    
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
    
    function submit(address _to, uint256 _value, bytes calldata _data) external onlyOwner returns (uint256) {
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false,
            confirmations: 0
        }));
        
        uint256 txId = transactions.length - 1;
        emit Submit(txId);
        return txId;
    }
    
    function confirm(uint256 _txId) external onlyOwner {
        require(_txId < transactions.length, "Invalid tx");
        require(!confirmed[_txId][msg.sender], "Already confirmed");
        require(!transactions[_txId].executed, "Already executed");
        
        confirmed[_txId][msg.sender] = true;
        transactions[_txId].confirmations++;
        
        emit Confirm(_txId, msg.sender);
    }
    
    function execute(uint256 _txId) external onlyOwner {
        require(_txId < transactions.length, "Invalid tx");
        Transaction storage transaction = transactions[_txId];
        require(!transaction.executed, "Already executed");
        require(transaction.confirmations >= required, "Not enough confirmations");
        
        transaction.executed = true;
        
        (bool success,) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "Execution failed");
        
        emit Execute(_txId);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EscrowService {
    enum EscrowStatus { Active, Completed, Refunded, Disputed }
    
    struct Escrow {
        address payer;
        address payee;
        address arbitrator;
        uint256 amount;
        EscrowStatus status;
        uint256 createdAt;
    }
    
    mapping(uint256 => Escrow) public escrows;
    uint256 public escrowCount;
    
    event EscrowCreated(uint256 indexed escrowId, address indexed payer, address indexed payee, uint256 amount);
    event EscrowCompleted(uint256 indexed escrowId);
    event EscrowRefunded(uint256 indexed escrowId);
    event DisputeRaised(uint256 indexed escrowId);
    
    function createEscrow(address _payee, address _arbitrator) external payable returns (uint256) {
        require(msg.value > 0, "Amount must be > 0");
        require(_payee != address(0) && _payee != msg.sender, "Invalid payee");
        
        uint256 escrowId = escrowCount++;
        escrows[escrowId] = Escrow({
            payer: msg.sender,
            payee: _payee,
            arbitrator: _arbitrator,
            amount: msg.value,
            status: EscrowStatus.Active,
            createdAt: block.timestamp
        });
        
        emit EscrowCreated(escrowId, msg.sender, _payee, msg.value);
        return escrowId;
    }
    
    function completeEscrow(uint256 _escrowId) external {
        Escrow storage escrow = escrows[_escrowId];
        require(escrow.status == EscrowStatus.Active, "Not active");
        require(msg.sender == escrow.payer, "Only payer");
        
        escrow.status = EscrowStatus.Completed;
        payable(escrow.payee).transfer(escrow.amount);
        
        emit EscrowCompleted(_escrowId);
    }
    
    function refund(uint256 _escrowId) external {
        Escrow storage escrow = escrows[_escrowId];
        require(escrow.status == EscrowStatus.Active, "Not active");
        require(msg.sender == escrow.payee, "Only payee");
        
        escrow.status = EscrowStatus.Refunded;
        payable(escrow.payer).transfer(escrow.amount);
        
        emit EscrowRefunded(_escrowId);
    }
    
    function raiseDispute(uint256 _escrowId) external {
        Escrow storage escrow = escrows[_escrowId];
        require(escrow.status == EscrowStatus.Active, "Not active");
        require(msg.sender == escrow.payer || msg.sender == escrow.payee, "Unauthorized");
        
        escrow.status = EscrowStatus.Disputed;
        emit DisputeRaised(_escrowId);
    }
    
    function resolveDispute(uint256 _escrowId, bool payToPayee) external {
        Escrow storage escrow = escrows[_escrowId];
        require(escrow.status == EscrowStatus.Disputed, "Not disputed");
        require(msg.sender == escrow.arbitrator, "Only arbitrator");
        
        if (payToPayee) {
            escrow.status = EscrowStatus.Completed;
            payable(escrow.payee).transfer(escrow.amount);
        } else {
            escrow.status = EscrowStatus.Refunded;
            payable(escrow.payer).transfer(escrow.amount);
        }
    }
}

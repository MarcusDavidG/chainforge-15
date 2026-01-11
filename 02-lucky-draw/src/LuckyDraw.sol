// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract LuckyDraw {
    struct Draw {
        uint256 ticketPrice;
        uint256 endTime;
        address[] participants;
        address winner;
        bool finalized;
        uint256 prizePool;
    }

    Draw[] public draws;
    address public owner;
    uint256 public ownerFeePercent = 5; // 5% fee

    event DrawCreated(uint256 indexed drawId, uint256 ticketPrice, uint256 endTime);
    event TicketPurchased(uint256 indexed drawId, address indexed participant);
    event WinnerSelected(uint256 indexed drawId, address indexed winner, uint256 prize);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createDraw(uint256 _ticketPrice, uint256 _duration) external onlyOwner returns (uint256) {
        require(_ticketPrice > 0, "Invalid ticket price");
        require(_duration > 0, "Invalid duration");

        draws.push(Draw({
            ticketPrice: _ticketPrice,
            endTime: block.timestamp + _duration,
            participants: new address[](0),
            winner: address(0),
            finalized: false,
            prizePool: 0
        }));

        uint256 drawId = draws.length - 1;
        emit DrawCreated(drawId, _ticketPrice, block.timestamp + _duration);

        return drawId;
    }

    function buyTicket(uint256 _drawId) external payable {
        require(_drawId < draws.length, "Invalid draw ID");
        Draw storage draw = draws[_drawId];
        require(block.timestamp < draw.endTime, "Draw ended");
        require(!draw.finalized, "Draw finalized");
        require(msg.value == draw.ticketPrice, "Incorrect ticket price");

        draw.participants.push(msg.sender);
        draw.prizePool += msg.value;

        emit TicketPurchased(_drawId, msg.sender);
    }

    function selectWinner(uint256 _drawId) external {
        require(_drawId < draws.length, "Invalid draw ID");
        Draw storage draw = draws[_drawId];
        require(block.timestamp >= draw.endTime, "Draw not ended");
        require(!draw.finalized, "Already finalized");
        require(draw.participants.length > 0, "No participants");

        // Simple pseudo-random selection (for demo purposes)
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(
            block.timestamp,
            block.prevrandao,
            draw.participants.length
        ))) % draw.participants.length;

        address winner = draw.participants[randomIndex];
        draw.winner = winner;
        draw.finalized = true;

        uint256 fee = (draw.prizePool * ownerFeePercent) / 100;
        uint256 prize = draw.prizePool - fee;

        payable(winner).transfer(prize);
        payable(owner).transfer(fee);

        emit WinnerSelected(_drawId, winner, prize);
    }

    function getDrawDetails(uint256 _drawId) external view returns (
        uint256 ticketPrice,
        uint256 endTime,
        uint256 participantCount,
        address winner,
        bool finalized,
        uint256 prizePool
    ) {
        require(_drawId < draws.length, "Invalid draw ID");
        Draw storage draw = draws[_drawId];
        return (
            draw.ticketPrice,
            draw.endTime,
            draw.participants.length,
            draw.winner,
            draw.finalized,
            draw.prizePool
        );
    }

    function getParticipants(uint256 _drawId) external view returns (address[] memory) {
        require(_drawId < draws.length, "Invalid draw ID");
        return draws[_drawId].participants;
    }

    function getDrawCount() external view returns (uint256) {
        return draws.length;
    }

    function setOwnerFee(uint256 _feePercent) external onlyOwner {
        require(_feePercent <= 20, "Fee too high");
        ownerFeePercent = _feePercent;
    }
}

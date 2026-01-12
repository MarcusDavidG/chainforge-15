// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title MessageBoard
/// @notice A decentralized bulletin board for posting and managing messages
/// @dev Implements pay-to-post mechanism with categories and editing capabilities
contract MessageBoard {
    /// @notice Structure representing a message on the board
    /// @dev Stores all message metadata including edit status
    struct Message {
        address author;      // Address of message creator
        string content;      // Message text content
        uint256 timestamp;   // Block timestamp when posted
        uint256 category;    // Category identifier
        bool edited;         // Whether message has been edited
    }

    Message[] public messages;
    uint256 public postFee = 0.0001 ether;
    address public owner;
    
    event MessagePosted(uint256 indexed messageId, address indexed author, string content, uint256 category);
    event MessageEdited(uint256 indexed messageId, string newContent);
    event FeeUpdated(uint256 newFee);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function postMessage(string calldata _content, uint256 _category) external payable returns (uint256) {
        require(msg.value >= postFee, "Insufficient fee");
        require(bytes(_content).length > 0, "Empty message");
        require(bytes(_content).length <= 500, "Message too long");

        messages.push(Message({
            author: msg.sender,
            content: _content,
            timestamp: block.timestamp,
            category: _category,
            edited: false
        }));

        uint256 messageId = messages.length - 1;
        emit MessagePosted(messageId, msg.sender, _content, _category);

        return messageId;
    }

    function editMessage(uint256 _messageId, string calldata _newContent) external {
        require(_messageId < messages.length, "Invalid message ID");
        require(messages[_messageId].author == msg.sender, "Not message author");
        require(bytes(_newContent).length > 0, "Empty message");
        require(bytes(_newContent).length <= 500, "Message too long");

        messages[_messageId].content = _newContent;
        messages[_messageId].edited = true;

        emit MessageEdited(_messageId, _newContent);
    }

    function getMessage(uint256 _messageId) external view returns (
        address author,
        string memory content,
        uint256 timestamp,
        uint256 category,
        bool edited
    ) {
        require(_messageId < messages.length, "Invalid message ID");
        Message memory msg_ = messages[_messageId];
        return (msg_.author, msg_.content, msg_.timestamp, msg_.category, msg_.edited);
    }

    function getMessageCount() external view returns (uint256) {
        return messages.length;
    }

    function getMessagesByCategory(uint256 _category) external view returns (uint256[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < messages.length; i++) {
            if (messages[i].category == _category) {
                count++;
            }
        }

        uint256[] memory result = new uint256[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < messages.length; i++) {
            if (messages[i].category == _category) {
                result[index] = i;
                index++;
            }
        }

        return result;
    }

    function setPostFee(uint256 _newFee) external onlyOwner {
        postFee = _newFee;
        emit FeeUpdated(_newFee);
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}

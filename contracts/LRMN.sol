// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

contract LRMN is Ownable, Pausable {
    struct LRMNMessage {
        uint256 index;
        uint256 timestamp;
        address sender;
        string message;
    }

    uint256 public constant MAX_MESSAGES = 10;

    uint256 public lrmnFee;
    uint256 public totalMessages;
    mapping(address => uint256) public messageCount;
    mapping(uint256 => LRMNMessage) public messages;

    event LRMNEvent(
        address indexed sender,
        string message,
        uint256 senderMessageCount,
        uint256 totalMessages
    );
    event FeeUpdated(uint256 newFee);
    event LRMNPaused(bool isPaused);

    constructor(uint256 _fee) Ownable(msg.sender) {
        lrmnFee = _fee;
    }

    function sendMessage(string calldata message) external payable whenNotPaused {
        require(msg.value >= lrmnFee, "Insufficient fee");

        messages[totalMessages] = LRMNMessage(
            totalMessages,
            block.timestamp,
            msg.sender,
            message
        );
        totalMessages++;
        messageCount[msg.sender]++;

        emit LRMNEvent(msg.sender, message, messageCount[msg.sender], totalMessages);
    }

    function getLastMessages() external view returns (LRMNMessage[] memory) {
        uint256 count = totalMessages < MAX_MESSAGES ? totalMessages : MAX_MESSAGES;
        LRMNMessage[] memory lastMessages = new LRMNMessage[](count);

        for (uint256 i = 0; i < count; i++) {
            lastMessages[i] = messages[totalMessages - 1 - i];
        }

        return lastMessages;
    }

    function updateFee(uint256 newFee) external onlyOwner {
        lrmnFee = newFee;
        emit FeeUpdated(newFee);
    }

    function pause() external onlyOwner whenNotPaused {
        _pause();
        emit LRMNPaused(true);
    }

    function unpause() external onlyOwner whenPaused {
        _unpause();
        emit LRMNPaused(false);
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}

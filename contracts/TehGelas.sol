// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

contract TehGelas is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit {
    struct TGSMessage {
        uint256 index;
        uint256 timestamp;
        address sender;
        string message;
    }

    uint256 public constant MAX_MESSAGES = 10;
    uint256 public constant INITIAL_SUPPLY = 5_000_000_000 * 10 ** 18;

    uint256 public btFee;
    uint256 public totalMessages;
    mapping(address => uint256) public messageCount;
    mapping(uint256 => TGSMessage) public messages;

    event TGSMessageSent(
        address indexed sender,
        string message,
        uint256 senderMessageCount,
        uint256 totalMessages
    );
    event FeeUpdated(uint256 newFee);
    event TGSPaused(bool isPaused);

    constructor(address initialOwner, address recipient, uint256 _fee)
        ERC20("TehGelas", "TGS")
        Ownable(initialOwner)
        ERC20Permit("TehGelas")
    {
        _mint(recipient, INITIAL_SUPPLY);
        btFee = _fee;
    }

    function pause() external onlyOwner whenNotPaused {
        _pause();
        emit TGSPaused(true);
    }

    function unpause() external onlyOwner whenPaused {
        _unpause();
        emit TGSPaused(false);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function sendMessage(string calldata message) external payable whenNotPaused {
        require(msg.value >= btFee, "Insufficient fee");

        messages[totalMessages] = TGSMessage(
            totalMessages,
            block.timestamp,
            msg.sender,
            message
        );
        totalMessages++;
        messageCount[msg.sender]++;

        emit TGSMessageSent(msg.sender, message, messageCount[msg.sender], totalMessages);
    }

    function getLastMessages() external view returns (TGSMessage[] memory) {
        uint256 count = totalMessages < MAX_MESSAGES ? totalMessages : MAX_MESSAGES;
        TGSMessage[] memory lastMessages = new TGSMessage[](count);

        for (uint256 i = 0; i < count; i++) {
            lastMessages[i] = messages[totalMessages - 1 - i];
        }

        return lastMessages;
    }

    function updateFee(uint256 newFee) external onlyOwner {
        btFee = newFee;
        emit FeeUpdated(newFee);
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // Override required by Solidity
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}

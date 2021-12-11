// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

/// @title A minimalist service for posting messages.
/// @author Cyril Kato
/// @notice This contract could be used for microblogging.
contract Log {
    address payable private immutable OWNER_ADDR;

    event Post(string message);

    modifier onlyOwner() {
        require(isOwner(), "Not owner");

        _;
    }

    constructor() {
        OWNER_ADDR = payable(msg.sender);
    }

    receive() external payable {
    }

    fallback() external payable {
    }

    /// @notice Post a message.
    /// @dev IPFS CIDs may be posted.
    /// @param _message The message to post.
    function post(string memory _message) external onlyOwner() {
        emit Post(_message);
    }

    /// @notice Withdraw the contract.
    function withdraw() external {
        OWNER_ADDR.transfer(getBalance());
    }

    function getBalance() private view returns (uint256) {
        return address(this).balance;
    }

    function isOwner() private view returns (bool) {
        return msg.sender == OWNER_ADDR;
    }
}

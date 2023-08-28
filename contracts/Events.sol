// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// Structs
contract Events1 {
    string public message = "Hello World";

    // events can have up to 17 arguments
    // you can index up to 3 arguments
    event MessageUpdated(
        address indexed _user,
        string _message
    );

    function updateMessage(string memory _message) public {
        message = _message;
        emit MessageUpdated(msg.sender, _message);
    }
}

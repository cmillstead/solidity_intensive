// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// state variable with default value
contract Variables1 {
    string public name = "Example 1";
}

// constructor assigns state variable
contract Variables2 {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// functions can assign state variables
contract Variables3 {
    string name;

    function setName(string memory _name) public {
        name = _name;
    }

    function getName() public view returns(string memory) {
        return name;
    }
}

// constants are set in the contract
contract Variables4 {
    string constant NAME = "Example 4";
    address immutable OWNER;

    constructor() {
        OWNER = msg.sender;
    }

    function name() public pure returns(string memory) {
        return NAME;
    }

    function owner() public view returns(address) {
        return OWNER;
    }
}

// global vairables: this, msg, tx, block
contract Variables5 {
    address public contractAddress;
    address public payer;
    address public origin;
    uint public amount;

    constructor() {
        contractAddress = address(this);
    }

    function pay() public payable {
        payer = msg.sender;
        origin = tx.origin;
        amount = msg.value;
    }

    function getBlockInfo() public view returns(uint, uint, uint) {
        return(
            block.number,
            block.timestamp,
            block.chainid
        );
    }
}

// visibility
contract Variables6 {
    // no visibility
    // defaults to internal
    string name1 = "Name 1";
    // private variables can only be accessed inside the current contract
    string private name2 = "Name 2";
    // internal variables can only be accessed internally
    string internal name3 = "Name 3";
    // public variables can be accessed internally and externally
    string public name4 = "Name 4";
}

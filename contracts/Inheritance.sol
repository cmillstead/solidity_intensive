// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Ownable {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(
            msg.sender == owner, 
            'caller must be owner'
        );
        _;
    }
}

contract Inheritance1 is Ownable {
    string public name = "Example 1";

    // constructor is inherited from parent
    // ownalbe modifier inherited from parent

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }
}

contract Payable {
    // lets the contract receive Ether
    receive() external payable {}
}

contract Inheritance2 is Ownable, Payable {
    // inerits ownership from Ownable
    // inherits deposit functionality from Payable

    // withdraws ether funds from the contract
    function withdraw() public onlyOwner {
        uint256 value = address(this).balance;
        (bool sent, ) = owner.call{value: value}("");
        require(sent, "Failed to send Ether");
    }
}

contract Token1 {
    uint public totalSupply;

    constructor(uint _totalSupply) {
        totalSupply = _totalSupply;
    }
}

contract Inheritance3 is Token1 {
    string public name;
    string public symbol;
    uint public decimals;

    constructor() Token1(1000000 * (10 ** 18)) {
        name = "My Token";
        symbol = "MTK";
        decimals = 18;
    }
}

contract Token2 {
    uint public totalSupply;
    string public name = "My Token";
    string public symbol = "MTK";
    uint public decimals = 18;

    mapping (address => uint) balances;

    constructor(uint _totalSupply) {
        totalSupply = _totalSupply * (10 ** 18);
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address _account) virtual public view returns(uint) {
        return balances[_account];
    }
}

contract Inheritance4 is Token2 {

    constructor(uint _totalSupply) Token2(_totalSupply) {

    }

    function balanceOf(address _account) virtual override public view returns(uint) {
        uint balance = super.balanceOf(_account);
        return balance * 10;
    }
}
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// read functions are free
// write functions cost gas
contract Functions1 {
    string name = "Example 1";

    function setName(string memory _name) public {
        name = _name;
    }

    function getName() public view returns(string memory) {
        return name;
    }

    function resetName() public {
        name = "Example 1";
    }
}


// functions can call other functions
// only public functions are visible outside the contract
contract Functions2 {
    uint public count;

    function increment() public {
        count = add(count, 1);
    }

    function add(uint a, uint b) internal pure returns(uint) {
        return a + b;
    }
}


// functions can be declared outside the contract
function addNumbers(uint a, uint b) pure returns(uint) {
    return a + b;
}

contract Functions3 {
    uint public count;

    function increment() public {
        count = addNumbers(count, 1);
    }
}

// visibility
// public: visible externally and internally
// private: only visible in the current contract
// external: only visible externally (only for functions) 
// internal: only visible internally
contract Functions4 {
    uint public count;

    function increment1() public {
        count = count + 1;
    }

    function increment2() public {
        increment1();
    }

    // only visible in the current contract
    // you *can* call this from another function inside this contract
    // you *cannot* call this from another contract
    function increment3() private {
        count = count + 1;
    }

    function increment4() public {
        increment3();
    }

    // you cannot call this function inside another function
    // it won't even compile
    function increment5() external {
        count = count + 1;
    }

    // you cannot call this outside the contract
    // you *can* call this from another function
    // you *can* call this from an inherited contract
    function increment6() internal {
        count = count + 1;
    }

    function increment7() public {
        increment6();
    }
}

contract Functions5 {
    string public name = "Example 5";
    uint public balance;

    function getName() public view returns(string memory) {
        return name;
    }

    function add(uint a, uint b) public pure returns(uint) {
        return a + b;
    }

    function pay() public payable {
        balance = msg.value;
    }
}

contract Functions6 {
    address private owner;
    string public name = "";
    bool private nameSet = false;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, 'caller must be owner');
        _;
    } 

    modifier onlyOnce {
        require(nameSet == false, 'can only set name once');
        _;
    }

    function setName1(string memory _name) onlyOwner public {
        name = _name;
    }

    function setName2(string memory _name) onlyOwner onlyOnce public {
        name = _name;
        nameSet = true;
    }
}

contract Functions7 {
    string name = "Example 7";

    function getName1() public view returns(string memory) {
        return name;
    }

    function getName2() public view returns(string memory) {
        name;
    }

    function getName3() public view returns(string memory) {
        return getName1();
    }

    function getName4() public view returns(string memory anotherName) {
        anotherName = "Another name";
    }

    function getName5() public view returns(string memory anotherName) {
        anotherName = getName4();
    }

    function getName6() public view returns(string memory name1, string memory name2) {
        return(name, "New name");
    }

    function getName7() public view returns(string memory name1, string memory name2) {
        (name1, name2) = getName6();
        return(name1, name2);
    }

    event NameChanged(string name);

    function setName1() public returns(string memory) {
        name = "New name";
        emit NameChanged(name);
        return name;
    }

    function setName2() public returns(string memory newName) {
        newName = "New name";
        name = newName;
        return name;
    }

    function setName3() public returns(string memory newName) {
        newName = setName2();
        emit NameChanged(newName);
        return newName;
    }
}


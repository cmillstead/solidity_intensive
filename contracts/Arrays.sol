// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

 contract Arrays1 {
    uint[] public array1 = [1, 2, 3];
    uint[] public array2; // this initializes an array of uints
    uint[10] public array3; // this initializes a fixed size array of 10 uints, default to 0
    string[] public array4  = ["apple", "banana", "carrot"];
    string[] public array5; // this initializes an array of strings
    string[10] public array6; // this initializes a fixed size array of 10 uints, default to ""
}


 contract Arrays2 {
    uint[] public array;

    // get value at a given index
    function getIndex(uint i) public view returns (uint) {
        return array[i];
    }

    // return the whole array
    function getArray() public view returns (uint[] memory) {
        return array;
    }

    function length() public view returns (uint) {
        return array.length;
    }

    // adds new value at the end of the array
    function push(uint i) public {
        array.push(i);
    }

    // removes last item from array
    function pop() public {
        array.pop();
    }

    // remove item at given index
    function remove(uint index) public {
        delete array[index];
    }
}

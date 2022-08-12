// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/* modifier
event
tarih veritipi nasıl tutulur
openzeppelin 

testleri typescript ile yaz */

contract Admin_and_Parent {

    address private admin; 

    constructor()  {
        admin = msg.sender;
    }

    struct Parent {
        address payable _address;
        string name;
        string surname;
        address[] children;
    }

    struct Child {
        address payable _address;
        string name;
        string surname;
        // releasetime veya birthdate
        uint256 releaseTime;
        uint256 balance;
        address parentAddress;
    }

    mapping (address => Parent) private parents;
    mapping (address => Child) private children;

    function addParent(address payable _address, string memory name, string memory surname) public {
        Parent storage parent = parents[_address]; 
        require((parent._address == address(0)), "Parent already in system.");
        parent._address = _address;
        parent.name = name;
        parent.surname = surname;
    }

    function getParent() public view returns(Parent memory result) {
        Parent storage parent = parents[msg.sender]; 
        result = parent;
    }

}

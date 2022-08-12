// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.16;

import "hardhat/console.sol";

contract HelloWorld{
    string private hello = "Hello World !";

    function get() public view returns (string memory) {
        console.log("Should get hello world text");
        return(hello);
    }

    function set(string memory text) public {
        hello = text;
    }
}

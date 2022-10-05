//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Mappings {
    mapping(address => uint256) public userToBalance;

    constructor() {}

    function deposit(uint256 amount_) public {
        userToBalance[msg.sender] = amount_;
    }

    function checkBalance(address user_) public view returns (uint256) {
        return userToBalance[user_];
    }
}

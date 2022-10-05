//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract YourContract {
    mapping(address => uint256) public userToBalance;
    mapping(address => KYCUserData) public addressToUserData;

    struct KYCUserData {
        string name;
        uint256 age;
    }

    constructor() {}

    function deposit(uint256 amount_) public {
        userToBalance[msg.sender] = amount_;
    }

    function checkBalance(address user_) public view returns (uint256) {
        return userToBalance[user_];
    }

    function setUserDetails(string calldata name_, uint256 age_) public {
        addressToUserData[msg.sender] = KYCUserData(name_, age_);
    }

    function getUserDetail() public view returns (KYCUserData memory) {
        return addressToUserData[msg.sender];
    }
}

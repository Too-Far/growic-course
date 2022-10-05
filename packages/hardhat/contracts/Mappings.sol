//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Mappings {
    address payable owner;
    uint256 private constant FEE = 100;
    mapping(address => uint256) public userToBalance;
    mapping(address => uint256) public userToDeposits;
    mapping(address => KYCUserData) public addressToUserData;

    struct KYCUserData {
        string name;
        uint256 age;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "ERR: Must be owner");
        _;
    }

    modifier onlyDepositors() {
        require(userToBalance[msg.sender] > 0, "ERR: Must deposit first");
        _;
    }

    modifier amountExceedsFee(uint256 amount_) {
        require(amount_ >= FEE, "ERR: Value must exceed fee");
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit(uint256 amount_) public {
        userToBalance[msg.sender] += amount_;
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

    function addFund(uint256 amount_) public payable onlyDepositors {
        require(msg.value == amount_, "ERR: value amount mismatch");
        userToDeposits[msg.sender] += amount_;
    }

    function withdraw() public onlyOwner {
        require(owner.send(address(this).balance));
    }

    receive() external payable {
        userToDeposits[msg.sender] = msg.value;
    }
}

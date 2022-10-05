//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract StudentDetails {
    address public owner;

    enum Gender {
        Male,
        Female
    }

    mapping(address => Student) public addressToStudents;

    struct Student {
        string name;
        uint256 id;
        string Gender;
        bool exists;
        uint256[] marks;
        uint256 gradePercentage;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "ERR: Only callable by owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function register(address studentAddress_, Student calldata student_)
        public
        onlyOwner
    {
        require(
            !addressToStudents[studentAddress_].exists,
            "ERR: Already registered"
        );
        addressToStudents[studentAddress_] = student_;
    }

    function getStudentDetails(address studentAddress_)
        public
        view
        returns (Student memory)
    {
        return addressToStudents[studentAddress_];
    }
}

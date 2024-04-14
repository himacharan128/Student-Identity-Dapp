// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DigitalIdentity.sol";

contract TestDigiIdentity {
    DigiIdentity digiIdentity = DigiIdentity(DeployedAddresses.DigiIdentity());
    address constant ADMIN_ADDRESS = 0xBF965e9c5869e32B03f9CeDa94F2130A71DFe7f5;


    function testUserRegistration() public {
        string memory name = "John Doe";
        string memory fatherName = "John's Father";
        string memory rollNumber = "123456";
        string memory courseName = "Computer Science";
        string memory dob = "2000-01-01";
        string memory collegeEmail = "john@example.com";
        string memory imageHash = "imageHash123";

        digiIdentity.register(name, fatherName, rollNumber, courseName, dob, collegeEmail, imageHash);

        DigiIdentity.User memory newUser = digiIdentity.getUserByAddress(msg.sender);

        Assert.equal(newUser.name, name, "Name should match");
        Assert.equal(newUser.fatherName, fatherName, "Father's name should match");
        Assert.equal(newUser.rollNumber, rollNumber, "Roll number should match");
        Assert.equal(newUser.courseName, courseName, "Course name should match");
        Assert.equal(newUser.dob, dob, "Date of birth should match");
        Assert.equal(newUser.collegeEmail, collegeEmail, "College email should match");
        Assert.equal(newUser.imageHash, imageHash, "Image hash should match");
        Assert.equal(uint(newUser.status), uint(DigiIdentity.UserStatus.Pending), "User status should be pending");
    }

    function testAdminVerification() public {
        // Register a new user
        testUserRegistration();

        // Verify user as admin
        digiIdentity.addAdmin(ADMIN_ADDRESS);
        digiIdentity.verifyUser(msg.sender);

        DigiIdentity.User memory verifiedUser = digiIdentity.getUserByAddress(msg.sender);

        Assert.equal(uint(verifiedUser.status), uint(DigiIdentity.UserStatus.Active), "User should be verified");
    }

    function testAdminRejection() public {
        // Register a new user
        testUserRegistration();

        // Reject user as admin
        digiIdentity.addAdmin(ADMIN_ADDRESS);
        digiIdentity.rejectUser(msg.sender);

        DigiIdentity.User memory rejectedUser = digiIdentity.getUserByAddress(msg.sender);

        Assert.equal(uint(rejectedUser.status), uint(DigiIdentity.UserStatus.Rejected), "User should be rejected");
    }
}

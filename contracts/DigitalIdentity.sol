// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
// import "QRCoder.sol";

contract DigitalIdentity is Ownable(msg.sender) {
    using Strings for uint256;

    enum UserStatus { Pending, Active, Rejected }

    struct User {
        string name;
        string fatherName;
        string rollNumber;
        string courseName;
        string dob;
        string collegeEmail;
        string imageHash;
        bytes32 qrCode;
        UserStatus status;
    }

    mapping(address => User) public users;
    mapping(string => address) public rollNumberToAddress;

    event UserRegistered(address indexed user, string name);
    event UserVerified(address indexed user);
    event UserRejected(address indexed user);


    modifier restrictedToAdmin() {
        require(admins[msg.sender], "Restricted to admin");
        _;
    }

    mapping(address => bool) admins;

    constructor() {
        admins[msg.sender] = true;
    }

    function addAdmin(address _admin) public restrictedToAdmin {
        admins[_admin] = true;
    }


    function removeAdmin(address _admin) public restrictedToAdmin {
        require(_admin != msg.sender, "Cannot remove yourself as admin");
        admins[_admin] = false;
    }


    function register(
        string memory _name,
        string memory _fatherName,
        string memory _rollNumber,
        string memory _courseName,
        string memory _dob,
        string memory _collegeEmail,
        string memory _imageHash
    ) public {
        require(validateEmail(_collegeEmail), "Invalid college email format");
        require(rollNumberToAddress[_rollNumber] == address(0), "Roll number already registered");
    
        users[msg.sender] = User({
            name: _name,
            fatherName: _fatherName,
            rollNumber: _rollNumber,
            courseName: _courseName,
            dob: _dob,
            collegeEmail: _collegeEmail,
            imageHash: _imageHash,
            status: UserStatus.Pending,
            qrCode: ""
        });
        rollNumberToAddress[_rollNumber] = msg.sender;
    
        emit UserRegistered(msg.sender, _name);
    }
    


    function validateEmail(string memory /*email*/) internal pure returns (bool) {
        return true;
    }

    function verifyUser(address userAddress) public restrictedToAdmin {
        require(users[userAddress].status == UserStatus.Pending, "User is not pending verification");
        users[userAddress].status = UserStatus.Active;
        emit UserVerified(userAddress);
    }

    function rejectUser(address userAddress) public restrictedToAdmin {
        require(users[userAddress].status == UserStatus.Pending, "User is not pending verification");
        users[userAddress].status = UserStatus.Rejected;
        emit UserRejected(userAddress);
    }

    function generateQRCode() public {
        require(users[msg.sender].status == UserStatus.Active, "User is not verified");

        string memory qrCodeData = string(
            abi.encodePacked(
                "NAME:",
                users[msg.sender].name,
                "\nROLL NUMBER:",
                users[msg.sender].rollNumber,
                "\nEMAIL:",
                users[msg.sender].collegeEmail
            )
        );
        users[msg.sender].qrCode = keccak256(abi.encodePacked(qrCodeData)); // keccak256 hash as QR code justtt random
    }

    function getUserByAddress(address userAddress) public view returns (User memory) {
        require(userAddress != address(0), "Invalid user address");
        return users[userAddress];
    }
    // function generateQRCode() private pure returns (string memory) {
    //     uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
    //     bytes memory qrCodeData = abi.encodePacked(randomNumber);
    //     bytes memory qrCodeBytes = QRCoder.encode(qrCodeData);
    //     string memory qrCodeString = Strings.toString(qrCodeBytes);
    //     return Strings.toString(qrCodeBytes);
    // }
}

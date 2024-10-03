// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import { IGreeter } from "./interfaces/IGreeter.sol";

contract BuyMeACoffee {
    struct Coffee {
        address sender;
        string message;
        uint256 timestamp;
    }

    uint256 totalCoffee;
    address payable owner;
    IGreeter greeterAddress;

    event NewCoffee(address indexed sender, string message, uint256 timestamp);

    constructor(address _greeterAddress) {
        owner = payable(msg.sender);
        greeterAddress = IGreeter(_greeterAddress);
    }

    function buyMeACoffee(
        string memory _message
    ) public payable {
        require(msg.value > 0.001 ether, "Value must be greater than 0.001 ether");

        totalCoffee += 1;

        payable(owner).transfer(msg.value);
        greeterAddress.setGreeting(_message);

        emit NewCoffee(msg.sender, _message, block.timestamp);
    }

    function getTotalCoffee() public view returns (string memory) {
        
        return string(abi.encodePacked("Total coffee bought: ", totalCoffee, "Message: ", greeterAddress.greet()));
    }
}

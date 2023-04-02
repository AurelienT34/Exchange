pragma solidity 0.8.18;

import "hardhat/console.sol";

contract Owner {
    address owner;

    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender;
    }

    modifier isOwner() {
        require(owner == msg.sender, "Your are not the owner");
        _;
    }
}
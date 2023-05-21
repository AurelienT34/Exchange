// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Wallet {

    struct Balance {
        uint ethAmount;
        uint usdtAmount;
    }
    
    mapping(address => Balance) Wallets;

    function withdrawETH(address payable _to, uint _amount) external {
        require(_amount <= Wallets[msg.sender].ethAmount, "Not enought eth");
        Wallets[msg.sender].ethAmount -= _amount;
        _to.transfer(_amount);
    }

    function withdrawUSDT(address payable _to, uint _amount) external {
        require(_amount <= Wallets[msg.sender].usdtAmount, "Not enought usdt");
        Wallets[msg.sender].usdtAmount -= _amount;
        _to.transfer(_amount);
    }

    function getBalanceETH() external view returns(uint) {
        return Wallets[msg.sender].ethAmount;
    }

    function getBalanceUSDT() external view returns(uint) {
        return Wallets[msg.sender].usdtAmount;
    }

    function setUSDT(uint _amount) external {
        Wallets[msg.sender].usdtAmount += _amount;
    }

    receive() external payable {
        Wallets[msg.sender].ethAmount += msg.value;
    }

    fallback() external payable {

    }

}
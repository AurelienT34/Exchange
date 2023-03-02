pragma solidity 0.8.18;

contract test3 {

    struct wallet {
        uint balance;
        uint numPayments;
    }

    mapping(address => wallet) Wallets;

    function getBalance() public view returns(uint) {
        return Wallets[msg.sender].balance;
    }

    function withdrawAllMoney(address payable _to) public {
        _to.transfer(getBalance());
        Wallets[msg.sender].balance = 0;
    }

    function getNumPayments() public view returns(uint) {
        return Wallets[msg.sender].numPayments;
    }

    function getTotalBalance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        Wallets[msg.sender].balance += msg.value;
        Wallets[msg.sender].numPayments += 1;
    }

}
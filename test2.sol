pragma solidity 0.8.18;

contract test2 {

    address lastPersonne;
    uint balance;

    function getlastPersonne() public view returns(address) {
        return lastPersonne;
    }

    function getBalance() public view returns(uint) {
        return balance;
    }

    receive() external payable {
        lastPersonne = msg.sender;
        balance = balance + msg.value;
    }
}
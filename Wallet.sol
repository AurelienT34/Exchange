pragma solidity 0.8.18;
import './Owner.sol';

contract Wallet is Owner {

    struct Payment {
        uint amount;
        uint date;
    }

    struct balance {
        uint totalBalance;
        uint numPayment;
        mapping(uint => Payment) payments;
    }

    mapping(address => balance) Wallets;

    function getBalance() public isOwner view returns(uint) {
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public {
        uint amount = Wallets[msg.sender].totalBalance;
        Wallets[msg.sender].totalBalance = 0;
        _to.transfer(amount);
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require( _amount <= Wallets[msg.sender].totalBalance, "Not enought funds");
        Wallets[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    receive() external payable {
        Payment memory thisPayment = Payment(msg.value,block.timestamp);
        Wallets[msg.sender].payments[Wallets[msg.sender].numPayment] = thisPayment;
        Wallets[msg.sender].totalBalance += msg.value;
        Wallets[msg.sender].numPayment++;
    }
}
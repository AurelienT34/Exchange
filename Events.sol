pragma solidity 0.8.18;
import '@openzeppelin/contracts/utils/Strings.sol';

interface interfaceEvents {
    function concatener(string memory _stringA, uint _numberA, uint _numberB) external pure returns(string memory);
}


contract Events {

    uint[] numbers;
    event numberAdded(address _by, uint _number);

    function setNombre(uint _number) public {
        numbers.push(_number);
        emit numberAdded(msg.sender,_number);
    }

    function getFirstNombre(uint _index) public view returns(uint) {
        return numbers[_index];
    }

    function fois2(uint _number) public pure returns(uint) {
        return _number * 2;
    }

    function concatener(string memory _stringA, uint _numberA, uint _numberB) external pure returns(string memory) {
        return string(abi.encodePacked(_stringA,Strings.toString(_numberA),Strings.toString(_numberB)));
    }

}
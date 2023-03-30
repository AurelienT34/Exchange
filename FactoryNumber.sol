pragma solidity 0.8.18;

contract FactoryNumber {

    Number[] numbersContract;

    function creatNumberContract() external returns(address){
        numbersContract.push(new Number(100));
        return address(numbersContract[numbersContract.length -1]);
    }

    function getNumber(Number _Contract) external view returns(uint) {
        return _Contract.getNumber();
    }

    function setNumberByContract(Number _Contract, uint _number) external {
        _Contract.setNumber(_number);
    }

}

contract Number {
    uint number;

    constructor(uint _number) {
        number = _number;
    }

    function getNumber() external view returns(uint) {
        return number;
    }

    function setNumber(uint _number) external {
        number = _number;
    }

}
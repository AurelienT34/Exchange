pragma solidity 0.8.18;
import './Events.sol';

contract UtilisableEvents {

    address addressEvents; // adresse du contract à utiliser

    function setAdressEvents(address _addressOtherContract) external {
        addressEvents = _addressOtherContract;
    }

    function getConcatener(string memory _stringA, uint _numberA, uint _numberB) external view returns(string memory) {
        interfaceEvents e = interfaceEvents(addressEvents); // pointe vers l'autre contract
        return e.concatener(_stringA,_numberA,_numberB);
    }
}
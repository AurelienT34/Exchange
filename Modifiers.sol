pragma solidity 0.8.18;
import './Owner.sol';

contract Modifiers is Owner{ //Héritage
    uint nombre;

    function setNombre(uint _nombre) public isOwner{
        if(_nombre == 5) {
            revert('Not possible');
        } else {
            nombre = _nombre;
        }
    }

    function getNombre() public view isOwner returns(uint) {
        return nombre;
    }

    function boucleNombre(uint _nombre) public {
        for(uint i = 0; i < _nombre; i++) {
            if ( 1 == 1) {
                break;
            }
        }
        while(true) {
            // do something
        }
    }
}
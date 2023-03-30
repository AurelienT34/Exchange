pragma solidity 0.8.18;
import './Owner.sol';

contract mySecondContract is Owner{ //Héritage

    enum typeBien {terrain,appartement,maison}

    struct bien{
        uint id;
        string name;
        uint price;
        typeBien _typeBien;
    }

    mapping(address => bien[]) Possessions;
    uint compteur;

    function addBien(address _proprietaire, string memory _name, uint _price, typeBien _typeBien) public isOwner {
        require( _price > 1000, "Me bien doit couter plus de 1000 wei");
        require(uint(_typeBien) >=0, "Le type de bien n'est pas renseigne");
        require(uint(_typeBien) <= 2, "Le type de bien n'est pas reconnu");
        Possessions[_proprietaire].push(bien(compteur,_name,_price,_typeBien));
        compteur++;
    }

    function getBiens(address _proprietaire) public view isOwner returns(bien[] memory) {
        return Possessions[_proprietaire];
    }

    function getNombreDeBien(address _proprietaire) public view isOwner returns(uint) {
        return Possessions[_proprietaire].length;
    }

    function getMesBien()public view returns(bien[] memory) {
        return Possessions[msg.sender];
    }

}
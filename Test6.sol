pragma solidity 0.8.18;

contract Exercice {

    uint nombre;

    function setNombre(uint _nombre) public {

        require(_nombre != 10, 'le nombre ne peut etre egal a 10'); // nouvelle méthode
        /*if(_nombre == 10) {
            revert('le nombre ne peut etre egal a 10'); // arrêt de la fonction en concervant le gaz
        }*/
        nombre = _nombre;
    }

    function getNombre() public view returns(uint) {
        return nombre;
    }
}
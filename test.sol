pragma solidity 0.8.18;

contract test {

    uint nombre;
    bool monBool;
    address monAdresse;
    string maPhrase;

    function getNombre() public view returns(uint) {
        return nombre;
    }

    function setNombre(uint _nombre) public {
        nombre = _nombre;
    }

    function getMonBool() public view returns(bool) {
        return monBool;
    }

    function setMonBool(bool _monbool) public {
        monBool = _monbool;
    }

    function getMonAdresse() public view returns(address) {
        return monAdresse;
    }

    function setMonAdresse(address _adresse) public {
        monAdresse = _adresse;
    }

    function getmaPhrase() public view returns(string memory) {
        return maPhrase;
    }

    function setmaPhrase(string memory _maPhrase) public {
        maPhrase = _maPhrase;
    }

}
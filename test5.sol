pragma solidity 0.8.18;

contract Exercice {

    struct eleve {
        string nom;
        string prenom;
        uint[] notes;
    }

    mapping(address => eleve) Eleves;

    function addEleve(address _eleve, string memory _nom, string memory _prenom, uint[] memory _notes) public {
        setNom(_eleve,_nom);
        setPrenom(_eleve,_prenom);
        for(uint i = 0 ; i < _notes.length ; i++) {
            addNote(_eleve,_notes[i]);
        }
    }

    function addNote(address _eleve, uint _note) private {
        Eleves[_eleve].notes.push(_note);
    }

    function getNotes(address _eleve) public view returns(uint[] memory) {
        return Eleves[_eleve].notes;
    }

    function setNom(address _eleve, string memory _nom) private {
        Eleves[_eleve].nom = _nom;
    }

    function getNom(address _eleve) public view returns(string memory) {
        return Eleves[_eleve].nom;
    }

    function setPrenom(address _eleve, string memory _prenom) private {
        Eleves[_eleve].prenom = _prenom;
    }

    function getPrenom(address _eleve) public view returns(string memory) {
        return Eleves[_eleve].prenom;
    }
}
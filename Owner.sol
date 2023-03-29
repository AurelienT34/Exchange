contract Owner {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(owner == msg.sender, "You are not the owner");
        _;// Permet d'executer le code de la fonction si require is true
    }

}
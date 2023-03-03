pragma solidity 0.8.18;

contract Arrays {

     uint[] nombre;

     function addValue(uint _valeur) public {
         nombre.push(_valeur);
     }

     function updateValue(uint _valeur, uint _index) public {
         nombre[_index] = _valeur;
     }

     function deleteValue(uint _index) public {
         delete nombre[_index];
     }

     function getValue(uint _index) public view returns(uint) {
         return nombre[_index];
     }

     function getNombreX2() public view returns(uint[] memory) {
         uint[] memory nombreX2 = new uint[](nombre.length);

         for(uint i  =0 ; i < nombreX2.length ; i++) {
             nombreX2[i] = nombre[i] * 2;
         }

         return nombreX2;
     }

     function somme() public view returns(uint) {
         uint total = 0;
         for(uint i = 0 ; i < nombre.length ; i++) {
             total += nombre[i];
         }
         return total;
     }

}
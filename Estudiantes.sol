// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
 
contract estudiante{
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping(string => uint) private _notas_materias;
    string[] private materias;
 
    constructor(string memory nombre_, string memory apellido_, string memory curso_){
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }
 
    function apellido() public view returns (string memory){
        return _apellido;
    }
 
    function nombre_completo() public view returns (string memory){
        return string.concat(_nombre, _apellido);        
    }
 
    function curso() public view returns (string memory){
        return _curso;
    }    
 
    function set_nota_materia(string memory materia, uint nota) public{
        require(msg.sender == _docente, "Solo el docente puede establecer las notas.");
        _notas_materias[materia] = nota;        
        materias.push(materia);
    }
 
    function nota_materia(string memory materia) public view returns (uint){
        return _notas_materias[materia];
    }
 
    function aprobo(string memory materia) public view returns (bool){      
        if (_notas_materias[materia] >= 60){
            return true;
        }
 
        else{
            return false;
        }
    }
 
    function promedio() public view returns (uint){
        uint notas;
        uint division = 0;
 
        for (uint i; i <= materias.length; i++){
            notas += _notas_materias[materias[i]];
            division++;                      
        }
 
        return notas/division;
    }
}

/*Para hacer el primer extra debemos hacer un array de mappings. Es decir, debemos asignar el mapping notas_materia a bimestres. Esto podría hacerse convirtiendo el mapping(string => uint) private _notas_materias; en mapping(string => uint)[] private _notas_materias_boletin;
Esto serviría para asignar las notas de la siguiente forma _notas_materias_boletin [bimestre][materia] = nota.*/

/*Para hacer el segundo extra necesitamos hacer una función que habilite nuevos docentes. Para esto, antes debemos declarar una lista de adresses donde se guardarán todos los docentes que sean habilitados. Dentro de la función deberíaos hacer un for que vaya recorriendo las posiciones y nos devuelva true si el docente que está intentando agregar notas está habilitado (if adress del docente está dentro de nuestra lista de adresses, entonces bool = true). Además, deberíamos agregar en la fncion set_nota_materia que para que cualquier docente habilitado pueda cargar notas. Esto último sería algo así: require(msg.sender == _docente  || docentesAutorizados(msg.sender) == true, "Solo el docente puede establecer las notas.");*/

/*Para el tercer extra, debemos crear un evento Deposit al que le pasamos el adress, la materia y la nota. Luego, dentro de una función deposit confirmamos el evento haciendo una función del siguiente estilo: function deposit(string memory _materia, uint _nota) public payable. Dentro de esta, ponemos emit Deposit(msg.sender, _materia, _nota) para que finalmente se confirme el evento.*/
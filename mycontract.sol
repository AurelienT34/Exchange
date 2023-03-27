pragma solidity 0.8.18;

contract myFirstContract {

    address owner; //propriétaire du contrat

    struct Grade {
        string subject;
        uint grade;
    }

    struct Student {
        string firstname;
        string lastname;
        uint numberOfGrades;
        mapping(uint => Grade) grades;
    }

    mapping(address => Student) students;

    constructor() { // celui qui deploit le contract est le owner
        owner = msg.sender;
    }

    function studentExist(address _studentAddress) public view returns(bool) {
        bytes memory firstnameOfAdress = bytes(students[_studentAddress].firstname);
        return firstnameOfAdress.length == 0;
    }

    function addStudent(address _studentAddress, string memory _firstname, string memory _lastname) public {
        require(msg.sender == owner,"Not the owner");
        require(studentExist(_studentAddress), "Already exists");
        students[_studentAddress].firstname = _firstname;
        students[_studentAddress].lastname = _lastname;
    }

    function addGrade(address _studentAddress, string memory _subject, uint _grade) public {
        require(msg.sender == owner,"Not the owner");
        require(!studentExist(_studentAddress), "Student doesn't exists");
        students[_studentAddress].grades[students[_studentAddress].numberOfGrades].subject= _subject;
        students[_studentAddress].grades[students[_studentAddress].numberOfGrades].grade = _grade;
        students[_studentAddress].numberOfGrades++;
    }

    function getGrades(address _studentAddress) public view returns(uint[] memory) {
        require(msg.sender == owner,"Not the owner");
        require(!studentExist(_studentAddress), "Student doesn't exists");
        uint numberOfGradesThisStudent = students[_studentAddress].numberOfGrades;
        uint[] memory grades = new uint[](numberOfGradesThisStudent);

        for(uint i = 0; i < numberOfGradesThisStudent; i++) {
            grades[i] = students[_studentAddress].grades[i].grade;
        }
        return grades;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract election{

    //candidate
      struct Candidate{
        string name;
        bool isValid;
        uint votes;
      }
    //store candidate 
        mapping(uint=>Candidate) public candidatesList;
        uint public candidatesCount;
     //store voters
        mapping(address => bool) voters;
    address owner;
    //read condidate
     //construction to initialize variables
    constructor()public {
     owner=msg.sender;
    }
    //modifier 
    modifier onlyOwner(){
        require(msg.sender==owner,"only owner can add candidate");
        _;
    }
    //event
    event candidateAddedEvent(address add,string txt);
    event votedEvent(uint  indexed _candidateId);
    function addCandidate(string memory _name) public returns (bool)
    {
        //set candidate with initial votes=0
       candidatesCount++;
       candidatesList[candidatesCount]=Candidate(_name,true,0);
       return true;
    //   emit candidateAddedEvent("candidate added !!");
    }

  // function vote(uint _candidateId) public {
  //   //voters have not been previously voted
  //   require(!voters[msg.sender]);
     
  //   require(_candidateId >0 && _candidateId <=candidatesCount);

  //   voters[msg.sender]=true;
  //   candidatesList[candidatesCount].votes ++;

  //   votedEvent(_candidateId);
  // }

}
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract election{

    //candidate
      struct Candidate{
        uint id;
        string name;
        uint voteCount;
      }
    //store candidate 
        mapping(uint=>Candidate) public candidates;
        uint public candidatesCount;
     //store voters
        mapping(address => bool) public voters;
    address owner;
    //read condidate
     //construction to initialize variables
    constructor()public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    //modifier 
    modifier onlyOwner(){
        require(msg.sender==owner,"only owner can add candidate");
        _;
    }
    //event
    event candidateAddedEvent(address add,string txt);
    event votedEvent(uint  indexed _candidateId);
    function addCandidate(string memory _name) private returns (bool)
    {
        //set candidate with initial votes=0
       candidatesCount++;
       candidates[candidatesCount]=Candidate(candidatesCount,_name,0);
       return true;
    //   emit candidateAddedEvent("candidate added !!");
    }

 function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

}
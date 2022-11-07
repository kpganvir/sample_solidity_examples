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
        mapping(address=>Candidate) public candidatesList;
        uint public candidatesCount;


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
    event log(address add,string txt);

    function addCandidate(address _addr,string memory _name) public  onlyOwner
    {
        //set candidate with initial votes=0
       candidatesCount++;
       candidatesList[_addr]=Candidate(_name,true,0);
       emit log(_addr,"candidate added !!");
    }



}
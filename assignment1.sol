pragma solidity ^0.5.0; 

contract assigment2{

address addr;

struct Member{
    string name;
    uint8 balance;
    bool isValid;
}

mapping(address =>Member) accounts ;

address owner;

constructor() public
{
    owner=msg.sender;
}

modifier onlyOwner{

    require( msg.sender==owner,"you are not permitted to deposit amount");
    _;
}
modifier onlyMembers{
    require(accounts[msg.sender].isValid,"you are not permitted to withdraw amount");
    _;
}

event log(address add,string text);
event logTxn(string name,string text,uint8 amount);
// set members ,with initial balance=0
 function addMembers(address  _accAddress,string memory _name) public onlyOwner{
   
         accounts[_accAddress]=Member(_name,0,true);
         emit log(_accAddress ," member added !");

}

//deposit in member's account
function deposit(address   _addr,uint8 _amount) public onlyOwner returns (bool)
{
       
       if(  accounts[_addr].isValid  )
        {  
         accounts[_addr].balance=accounts[_addr].balance+_amount;
         return true;
        }
        else
            emit log(_addr," not a valid member!!");

}

function viewBalance(address _addr) public view returns (uint8)
{

   if(  accounts[_addr].isValid  )
        {  
         return accounts[_addr].balance;
       
        }
        
}


function withdrawAmount(address _addr,uint8  _amount) public  onlyMembers returns (string memory)
{
   if (accounts[_addr].balance >= _amount)
      { 
           accounts[_addr].balance = accounts[_addr].balance - _amount;
         
           return "withdrawal success !!";
      }
      else
      {
            emit log(_addr,"has insufficient balance ");
          return "insufficient balance !!" ;
      }
       
}






}
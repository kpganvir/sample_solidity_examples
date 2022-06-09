// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;


interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 );
    function transfer(address _to, uint256 _value) external returns (bool );
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool );

    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

event Transfer(address indexed _from, address indexed _to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract MyToken is IERC20 {

string   name;
string   symbol;
string   decimal;
address ownerAddress;
mapping(address => uint256) accounts;

mapping (address =>  mapping(address => uint256)) allowed;

uint256 total_supply;


modifier onlyAdmin{

          require(msg.sender==ownerAddress,"only owner can deposite/mint  tokens");
          _;
      }

constructor(string memory _name,string memory _symbol,string memory _decimal,uint256 _supply) 
 {
       
        name=_name;
        symbol=_symbol;
        decimal=_decimal;
        total_supply=_supply;
        ownerAddress=msg.sender;
        accounts[msg.sender]=total_supply;

}


//to get total balance of tokens
function totalSupply() public override view returns (uint256)
{
 return total_supply;

}




//to get remaining balance in given address 
function balanceOf(address _owner) public override view returns (uint256)
{
 return accounts[_owner];

}

function transfer(address  _to, uint256 _value) public  override returns (bool )
{
        require(_value <= accounts[msg.sender]) ;
        accounts[msg.sender] =   accounts[msg.sender] - _value;
        accounts[_to] =  accounts[_to] + _value;
        emit Transfer(msg.sender ,_to,_value);
        return true;

}


function mint(uint256 _tokens) public onlyAdmin returns (uint256)
{

    total_supply+= _tokens;
    accounts[msg.sender] += _tokens;
    return total_supply;
}
       //spender is allowed to spend tokens less that equal to _value
    function approve(address _spender, uint256 _value) public override returns (bool success)
    {
          require(_spender != address(0));
         allowed [msg.sender][_spender]= _value;
         emit Approval(msg.sender,_spender,_value);
         return true;
    }

    //can view allowence given to _spender by _owner (whoever call this funtion is owner)
    function allowance(address _owner, address _spender) public override view returns (uint256 remaining)
    {
       
              return  allowed [_owner][_spender];
    }
 
 function transferFrom(address _from, address _to, uint256 _value) public override returns (bool )
{
   
    require(_value <= accounts[_from]) ;
     require(_value <= allowed[_from][_to] ) ; 

    accounts[_from] -=  _value;
    accounts[_to] +=  _value;
    emit Transfer (_from ,_to,_value);
    return true;
}

}
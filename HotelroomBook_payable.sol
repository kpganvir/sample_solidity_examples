// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom{

address payable Owner;

enum Status{
    Vacant,Occupied
}

Status public currentStatus;

event Occupy(address _occupant,uint _value);
modifier onlyWhileVancant {

    require(currentStatus== Status.Vacant,"Currently occupied..");
    _;
}
modifier costs(uint _amount)
{
    require (msg.value>=_amount,"Not enough ether provided");
    _;
}

constructor() {
    Owner= payable(msg.sender);
    currentStatus=Status.Vacant;

}

function book() public payable onlyWhileVancant  costs(2)
{
//owner.transfer(msg.value);

currentStatus=Status.Occupied;

(bool sent, ) = Owner.call{value : msg.value}("");
require(sent);


emit Occupy(msg.sender,msg.value);
}


}
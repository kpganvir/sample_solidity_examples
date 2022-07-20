// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery{

address public manager;
address payable[] public participants;

event SenderLogger(address);
event ValueLogger(uint);

    constructor(){

        manager=msg.sender;

    }

    

    function buyLottery() external payable 
    {
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }

receive() external payable
{
     require(msg.value == 1 ether);
     participants.push(payable(msg.sender));
     emit SenderLogger(msg.sender);
     emit ValueLogger(msg.value);
}
modifier onlyManager{
    require(msg.sender==manager,"only manager can view balance");
    _;
}
    function getBalance() public onlyManager view returns(uint)
    {
        
        return address(this).balance;
    }


    function random() private view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }

    function selectWinner() public onlyManager  returns(address)
    {   
        
        require(participants.length >=3," require minimum 3 participants");
        uint r =random();
        uint index=r % participants.length;
        address payable winner=participants[index];
        winner.transfer(getBalance());
        participants =new address payable[](0);
        return winner;
    }


   function getParticipants() public view onlyManager returns (uint)
   {
       return participants.length;
   }



}
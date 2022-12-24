//SPDX-License-Identifier: Unlicensed

pragma solidity >=0.7.0;

contract donutSeller{
    address payable internal owner;   //state variable for owner i.e the deployer of this contact
    mapping(address=>uint) internal donutcount;  //keep track of donuts with each account

    constructor(){
    owner=payable(msg.sender);  //owner set to contract deployer
    donutcount[owner]=100;       //owner is the seller with 100 donuts initially
    }

    function donutIncrement(uint x) public {  //only owner can add new stock of donuts
        require(msg.sender==owner,"only owner can do it");
        donutcount[owner]+=x;
    } 

    function getDonutCount() public view returns(uint){  //gives donut cout of each account
        return donutcount[msg.sender];
    }
    
    function purchase(uint y) payable public {  
        
        //send donut from owner to buyer and send ether from buyer to owner
        //1 donut==1 ether
        
        require(msg.sender!=owner,"U can't buy ur own donut");
        require(donutcount[owner]>=y,"low balance");
        donutcount[owner]-=y;
        donutcount[msg.sender]+=y;
        uint amt=y*1000000000000000000;
        bool sent=owner.send(amt);
        require(sent,"failed");
    }

}
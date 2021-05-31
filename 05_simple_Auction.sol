// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract simpleAuction{
    //parameters of the simple auction
    address payable public beneficiary;
    uint public auctionEndTime;
    
    //current state of the auctionEndTime
    address public highestbidder;
    uint public highestbid;
    
    mapping(address=>uint)public pendingreturns;
    
    bool ended =false;
    
    event HighestbidIncrease(address bidder,uint amount);
    event AuctionEnded(address winner,uint amount);
    
    constructor(uint _biddingtime,address payable _beneficiary){
        beneficiary=_beneficiary;
        auctionEndTime=block.timestamp+_biddingtime;
    }
    function bid() public payable{
        if(block.timestamp>auctionEndTime){
            revert("The auction has already ended");
        }
        if(msg.value<=highestbid){
            revert("there is already a higher or equal bid");
        }
        if(highestbid!=0){
            pendingreturns[highestbidder]+=highestbid;
        }
        highestbidder=msg.sender;
        highestbid=msg.value;
        emit HighestbidIncrease(msg.sender,msg.value);
        
    }
    
    function withdraw() public returns(bool){
        uint amount =pendingreturns[msg.sender];
        if(amount>0){
            pendingreturns[msg.sender]=0;
            if(!payable(msg.sender).send(amount)){
                pendingreturns[msg.sender]=amount;
                return false;
            }
        }
        return true;
    }
    
    function auctionend()public{
        if(block.timestamp<auctionEndTime){
            revert("the auction has not ended yet");
        }
        if (ended){
            revert("the function auction ended has already been called");
        }
        ended=true;
        emit AuctionEnded(highestbidder,highestbid);
        beneficiary.transfer(highestbid);
        
    }
    
}
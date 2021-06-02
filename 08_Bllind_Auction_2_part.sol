// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract BlindAuction{
    
    //VARIABLES
    struct Bid{
        bytes32 blindedBid;
        uint deposit;
    }
    
    address payable public beneficiary;
    uint public biddingEnd;
    uint public revealEnd;
    bool public ended;
    
    mapping(address=>Bid[])public bids;
    
    address public highestBidder;
    uint public highestBid;
    
    mapping(address=> uint) pendingReturns;
    
    
    //EVENTS
    event AuctionEnded(address winner,uint highestBid);
    
    //MODIFIERS
    modifier onlyBefore(uint _time){require(block.timestamp < _time); _;}
    modifier onlyAfter(uint _time){require(block.timestamp > _time); _;}
    
    //FUNTIONS
    
    constructor(uint _biddingTime,uint _revealTime,address payable _beneficiary){
        beneficiary=_beneficiary;
        biddingEnd=block.timestamp + _biddingTime;
        revealEnd = biddingEnd + _revealTime;
    }
    
    function generateBlindedBidBytes32(uint value,bool fake) public view returns(bytes32){
        return keccak256(abi.encodePacked(value,fake));
    }
    
    function bid(bytes32 _blindedBid)public payable onlyBefore(biddingEnd){
        bids[msg.sender].push(Bid({
            blindedBid: _blindedBid,
            deposit:msg.value
        }))
    }
    
    function reveal(){
        
    }
    
    function auctionEnd() public payable onlyAfter(revealEnd){
        require(!ended);
        emit AuctionEnded(highestBidder,highestBid);
        ended=true;
        beneficiary.transfer(highestBid); 
        
    }
    
    function withdraw() public{
        uint amount=pendingReturns[msg.sender];
        if(amount>0){
            pendingReturns[msg.sender]=0;
            
            payable(msg.sender).transfer(amount);
        }
    }
    
    function placeBid(address bidder,uint value)internal returns(bool sucess){
        if(value<=highestBid){
            return false
        }
        if(highestBidder!=address(0)){
            pendingReturns[highestBidder]+=highestBid;
        }
        highestBid=value;
        highestBidder=bidder;
        return true;
    }
}
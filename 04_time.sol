// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract mygame{
    mapping(address=>Player)public players;
    uint public playercount=0;
    enum Level {novice,intermediate,advanced}
    //novice: 0
    //intermediate: 1
    //advances : 2
    
    struct Player{
        address playeraddress;
        Level playerlevel;
        string firstname;
        string lastname;
        uint timecreated;
    }
    function add(string memory firstname,string memory lastname)public {
        players[msg.sender]=Player(msg.sender,Level.novice,firstname,lastname,block.timestamp);
        playercount+=1;
    }
    function getPlayerLevel(address playeraddress) public view returns(Level){
        Player storage player=players[playeraddress];
        return player.playerlevel;
    }
    function changePlayerLevel(address playeraddress)public{
        Player storage player=players[playeraddress];
        if (block.timestamp>=player.timecreated+20){
            player.playerlevel=Level.intermediate;
        }
        
        
    }
}

contract coin{
    uint contractstarttime;
    
    address public minter;
    
    mapping(address=>uint)public balances;
    
    event sent(address from,address to,uint amount);
    
    modifier onlyminter{
        require(msg.sender==minter,"only minter can call dis functions");
        _;
    }
    modifier amountmint(uint amount){
        require(amount<=1e60);
        _;
    }
    
    modifier amountlessthanamount(uint amount){
        require(amount<=balances[msg.sender],"insufficient balance");
        _;
    }
    
    constructor(){
        minter=msg.sender;
        contractstarttime=block.timestamp;
    }
    
    function mint(address receiver,uint amount)public onlyminter amountmint(amount){
        balances[receiver]+=amount;
    }
    
    function send(address receiver,uint amount) public amountlessthanamount(amount){
        require(block.timestamp>=contractstarttime+30);
        balances[msg.sender]-=amount;
        balances[receiver]+=amount;
        emit sent(msg.sender,receiver,amount);
    }
    
}
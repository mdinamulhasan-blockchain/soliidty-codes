// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract mygame{
    uint public playercount=0;
    uint public pot=0;
    address public dealer;
    
    Player[] public playerInGame;
    
    
    
    mapping(address=>Player)public players;
    
    
    
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
    
    constructor(){
        dealer=msg.sender;
        
    }
    
    function add(string memory firstname,string memory lastname)private {
        Player memory newplayer=Player(msg.sender,Level.novice,firstname,lastname,block.timestamp);
        players[msg.sender]=newplayer;
        playerInGame.push(newplayer);
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
    function joingame(string memory firstname,string memory lastname)payable public{
        require(msg.value==25 ether,"the joiing fee is 25 ether");
        if(payable(dealer).send(msg.value)){
            add(firstname,lastname);
            playercount+=1;
            pot+=25;
        }
        
    }
    function payOutWinners(address loseraddress) payable public{
        require(msg.sender==dealer,"only dealer can payout the winners!");
        require(msg.value==pot*(1 ether));
        uint payoutperwinner=msg.value/(playercount-1);
        for (uint i=0;i<playerInGame.length;i++){
            address currentplayeraddress=playerInGame[i].playeraddress;
            if(currentplayeraddress!=loseraddress){
                payable(currentplayeraddress).transfer(payoutperwinner);
            }
        }
        
    }
}

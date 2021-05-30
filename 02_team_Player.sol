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
    }
    function add(string memory firstname,string memory lastname)public {
        players[msg.sender]=Player(msg.sender,Level.advanced,firstname,lastname);
        playercount+=1;
    }
    function getPlayerLevel(address playeraddress) public view returns(Level){
        return players[playeraddress].playerlevel;
    }
    
}
pragma solidity >=0.7.0 <0.9.0;

contract Ballot{
    //variables
    
    struct vote{
        address voterAddresss;
        bool choice;
    }
    
    struct voter{
        string voterName;
        bool voted;
    }
    
    uint private countResult;
    uint public finalResult;
    uint public totalVoter;
    uint public totalVote;
    
    address public ballotOfficialAddress;
    string public ballotOfficialName;
    string public proposal;
    
    mapping(uint => vote) private votes;
    mapping(address => voter) public voterRegister;
    
    enum State {Created,Voting,Ended}
    State public state;
    
   //modifiers
   //events
  //functions
  
  constructor(){
      
  }
  function addVoter(){
      
  }
  function startVote(){
      
  }
  function doVote(){
      
  }
  function endVote(){
      
  }
  
  
  
  
  
  
  
}
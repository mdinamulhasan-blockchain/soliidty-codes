// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract coin{
    address public minter;
    mapping(address =>uint) public balances;
    
    event Sent(address from,address to,uint amount);
    
    constructor(){
        minter=msg.sender;
    }
    
    function mint(address receiver,uint amount)public {
        require(msg.sender==minter);
        require(amount<=1e60);
        balances[receiver]+=amount;
    }
    function send(address receiver,uint amount) public{
        require(amount<=balances[msg.sender],"insufficient balance");
        balances[msg.sender]-=amount;
        balances[receiver]+=amount;
        emit Sent(msg.sender,receiver,amount);
        
    }
    
    
    
}
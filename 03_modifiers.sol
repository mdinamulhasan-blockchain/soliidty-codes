// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract coin{
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
    }
    
    function mint(address receiver,uint amount)public onlyminter amountmint(amount){
        balances[receiver]+=amount;
    }
    
    function send(address receiver,uint amount) public amountlessthanamount(amount){
        balances[msg.sender]-=amount;
        balances[receiver]+=amount;
        emit sent(msg.sender,receiver,amount);
    }
    
    
    
}
//
pragma solidity >=0.7.0 <0.9.0;

contract Escrow{
    
    //variables
    enum State {NOT_INITIATED, AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE }
    
    State public currState;
    
    bool public isBuyerIn;          //initcontract
    bool public isSellerIn;         //initContract
    
    uint public price;
    
    address public buyer;
    address payable public seller;
    
    //modifiers
    modifier onlyBuyer() {
        require(msg.sender==buyer,"only buyer can call this funtion");
        _;
    }
    
    modifier escrowNotStarted() {
        require(currState==State.NOT_INITIATED);
        _;
    }
    
    
    //functions
    constructor(address _buyer, address payable _seller, uint _price) {
        buyer=_buyer;
        seller=_seller;
        price=_price;
    }
    
    function initContract() {
        
    }
    
    function deposit() {
        
    }
    
    function confirmDelivery() {
        
    }
    
    function withdraw() {
        
    }
    
}
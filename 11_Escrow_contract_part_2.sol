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
        price=_price * (1 ether);
    }
    
    function initContract() escrowNotStarted public{
        if(msg.sender==buyer){
            isBuyerIn=true;
        }
        if(msg.sender==seller){
            isSellerIn=true;
        }
        if(isBuyerIn && isSellerIn) {
            currState=State.AWAITING_PAYMENT;
        }
    }
    
    function deposit() onlyBuyer public payable {
        require(currState==State.AWAITING_PAYMENT,"already paid");
        require(msg.value == price,"wrong amount");
        currState=State.AWAITING_DELIVERY;
    }
    
    function confirmDelivery() onlyBuyer public payable{
        require(currState==State.AWAITING_DELIVERY,"cannot confirm delhivery");
        seller.transfer(price);
        currState=State.COMPLETE;
    }
    
    function withdraw() onlyBuyer payable public {
        require(currState==State.AWAITING_DELIVERY,"cannot withdraw at this stage");
        payable(msg.sender).transfer(price);
        currState=State.COMPLETE;
    }
    
}
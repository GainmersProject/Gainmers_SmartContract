pragma solidity ^0.4.18;

import '../token/StandardToken.sol';
import '../math/SafeMath.sol';


/**
 * @title ModifiedCrowdsale
 * @dev ModifiedCrowdsale is based in Crowdsale. Crowdsale is a base contract for managing a token crowdsale,
 * allowing investors to purchase tokens with ether. This contract implements
 * such functionality in its most fundamental form and can be extended to provide additional
 * functionality and/or custom behavior.
 * The external interface represents the basic interface for purchasing tokens, and conform
 * the base architecture for crowdsales. They are *not* intended to be modified / overriden.
 * The internal interface conforms the extensible and modifiable surface of crowdsales. Override 
 * the methods to add functionality. Consider using 'super' where appropiate to concatenate
 * behavior.
 */
 
contract ModifiedCrowdsale {
    using SafeMath for uint256;

    // The token being sold
    StandardToken public token; 

    //Start and end timestamps where investments are allowed 
    uint256 public startTime;
    uint256 public endTime;

     // how many token units a buyer gets per wei
    uint256 public rate;

    // address where crowdsale funds are collected
    address public wallet;

    // amount of raised money in wei
    uint256 public weiRaised;

    /**
     * event for token purchase logging
     * @param purchaser who paid for the tokens
     * @param value weis paid for purchase
     * @param amount amount of tokens purchased
     */
    event TokenPurchase(address indexed purchaser, uint256 value, uint256 amount);

    /**
    * @param _startTime StartTime for the token crowdsale
    * @param _endTime EndTime for the token crowdsale     
    * @param _rate Number of token units a buyer gets per wei
    * @param _wallet Address where collected funds will be forwarded to
    */
    function ModifiedCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet) public  {
        
        require(_startTime >= now);
        require(_endTime >= _startTime);
        require(_rate > 0);
        require(_wallet != 0x0);

        startTime = _startTime;
        endTime = _endTime;
        rate = _rate;
        wallet = _wallet;
        
        token = createTokenContract(); 
    }

    // creates the token to be sold.
    // override this method to have crowdsale of a specific mintable token.
    function createTokenContract() 
        internal 
        returns(StandardToken) 
    {
        return new StandardToken();
    }

    /**
    * @dev fallback function ***DO NOT OVERRIDE***
    */
    function () external payable {
        buyTokens(msg.sender);
    }

    // low level token purchase function
    function buyTokens(address _beneficiary) public   payable {
        require(validPurchase());
        uint256 weiAmount = msg.value;

        // calculate token amount to be created
        uint256 tokens = weiAmount.mul(rate);
        tokens += getBonus(tokens);

        // update state
        weiRaised = weiRaised.add(weiAmount);

        require(token.transfer(_beneficiary, tokens)); 
        TokenPurchase(_beneficiary, weiAmount, tokens);

        forwardFunds();

        postBuyTokens();
    }

    // Action after buying tokens
    function postBuyTokens ()  internal 
    {
    }

    // send ether to the fund collection wallet
    // override to create custom fund forwarding mechanisms
    function forwardFunds() 
       internal 
    {
        wallet.transfer(msg.value);
    }

    // @return true if the transaction can buy tokens
    function validPurchase()  internal  view
        returns(bool) 
    {
        bool withinPeriod = now >= startTime && now <= endTime;
        bool nonZeroPurchase = msg.value != 0;
        bool nonInvalidAccount = msg.sender != 0;
        return withinPeriod && nonZeroPurchase && nonInvalidAccount;
    }

    // @return true if crowdsale event has ended
    function hasEnded() 
        public 
        constant 
        returns(bool) 
    {
        return now > endTime;
    }


    /**
      * @dev Get the bonus based on the buy time 
      * @return the number of bonus token
    */
    function getBonus(uint256 _tokens) internal view returns (uint256 bonus) {
        require(_tokens != 0);
        if (startTime <= now && now < startTime + 7 days ) {
            return _tokens.div(5);
        } else if (startTime + 7 days <= now && now < startTime + 14 days ) {
            return _tokens.div(10);
        } else if (startTime + 14 days <= now && now < startTime + 21 days ) {
            return _tokens.div(20);
        }

        return 0;
    }
}

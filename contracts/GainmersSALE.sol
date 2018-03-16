pragma solidity ^0.4.18;

import "./OZ_contracts/crowdsale/CappedCrowdsale.sol";
import "./OZ_contracts/token/StandardToken.sol";
import "./GainmersTOKEN.sol";

/**
 * @title GainmersSALE
 * @dev 
 * GainmersSALE inherits form the Ownable and CappedCrowdsale,
 *
 * @author Gainmers.Teamdev
 */
contract GainmersSALE is Ownable, CappedCrowdsale {
    
    //Total supply of the GainmersTOKEN
    uint public constant TotalTOkenSupply = 100000000;

    //Hardcap of the ICO in wei
    uint private constant Hardcap = 30000 ether;

    //Exchange rate EHT/ GMR token
    uint private constant RateExchange = 1660;

   

    /**Initial distribution of the Tokens*/

    // Token initialy distributed for the team management and developer incentives (10%)
    address public constant TeamWallet = 0x627306090abaB3A6e1400e9345bC60c78a8BEf57;
    uint public constant TeamWalletAmount = 10000000e18; 
    
     // Token initialy distributed for the Advisors and sponsors (10%)
    address public constant TeamAdvisorsWallet = 0xf17f52151EbEF6C7334FAD080c5704D77216b732;
    uint public constant AdvisorsAmount = 10000000e18;
    
     // Token initially distribuded for future invesment rounds and prizes in the plataform (15%)
    address public constant 
    ReinvestWallet = 0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef;
    uint public constant ReinvestAmount = 15000000e18;

     // Token initialy distributed for  Bounty Campaing (5%)
    address public constant BountyCampaingWallet = 0x821aEa9a577a9b44299B9c15c88cf3087F3b5544;
    uint public constant BountyAmount = 5000000e18;

    //Event trigger if the Crowdsale reaches the hardcap
     event TokenSaleSoldOut();

    //Period after the sale for the token to be transferable
    uint public constant AfterSaleTransferableTime = 2 days;


    function GainmersSALE(uint256 _startTime, uint256 _endTime) public
      CappedCrowdsale(Hardcap)
      ModifiedCrowdsale(_startTime,
                         _endTime, 
                         RateExchange, 
                         TeamWallet)
    {
        
        token.transfer(TeamWallet, TeamWalletAmount);
        token.transfer(TeamAdvisorsWallet, AdvisorsAmount);
        token.transfer(ReinvestWallet, ReinvestAmount);
        token.transfer(BountyCampaingWallet, BountyAmount);


        
    }

    /**
     * @dev Handles the creation of the GainmersTOKEN
     * @return the  StandardToken 
     */
    function createTokenContract () 
      internal 
      returns(StandardToken) 
    {
        return new GainmersTOKEN(TotalTOkenSupply,
         endTime.add(AfterSaleTransferableTime),
        TeamWallet);
    }



    /**
     * @dev Drain the remaining tokens of the crowdsale to the TeamWallet account
     * @dev Only for owner
     * @return the StandardToken 
     */
    function drainRemainingToken () 
      public
      onlyOwner
    {
        require(hasEnded());
        token.transfer(TeamWallet, token.balanceOf(this));
    }


    /** 
    * @dev Allows the early transfer of tokens if the ICO end before the end date
    */

    function postBuyTokens ()  internal {
        if ( weiRaised >= Hardcap ) {  
            GainmersTOKEN gainmersToken = GainmersTOKEN (token);
            gainmersToken.enableTransferEarlier();
            TokenSaleSoldOut();
        }
    }
}
  

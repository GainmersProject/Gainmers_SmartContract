# Gainmers Token Crowdsale
As in this document we will cover the token sale specifications and details for the Initial Coin Offering of the Gainmers Project .

## ICO Specifications

* Total Token Supply: 100,000,000 GMR
* CrowdSale Supply: 60,000,000 GMR
* Pricing: 1 ETH = 1160 GMR 
* HardCap: 30000 ETH
* Bonus: 20% the first week after contract deployment, 10% the second and 5 % the third week.
* Start Date: 19 March , 00 am  UTC-5 
* End Date:  15 April , 12 pm UTC-5

## Detailed description

### Overview of the CrowdSale Flow
 Overview of the dates on the ICO
1. March 19, 00 am  UTC-5 is the start date for the ICO. We will deploy the "GainmersSALE.sol" contract that day, in which the "GainmersTOKEN.sol" contract will be called, creating the GMR token.
2. During the first week there will be a Bonus for the contributors of the project of 20% (March 19 until March 26).
3. During the second week there will be a Bonus for the contributors of the project of 10% (March 26 until April 2).
4. During the third week there will be a Bonus for the contributors of the project of 5% (April 2 until April 9).
5. April 15, 12 pm  UTC-5 is the end date for the project ICO.

#### The crowdsale (GainmersSALE.sol)

"GainmersSALE.sol" contains the implementation of the cappedcrowdsale. We used Open Zeppelin (OZ) OpenSource contracts for deveploping the smartcontract.
The "GainmersSALE.sol" contract inherits from "CappedCrowdsale.sol" by OZ providing the hardcap for the project. Also "CappedCrowdsale.sol" inherits form "ModifiedCrowdsale.sol". To obtain this file we did  small changes in the "Crowdsale.sol" file given by the OZ dev group, and so we created "ModifiedCrowdsale.sol". Were we add some basic check for the token deployment. This file will be the one handling the tokens and using the funciont getBonus() to calculate te exact ammount of tokens that will be given to the contributors address.

#### The token (GainmersTOKEN.sol)

"GainmersTOKEN.sol" contains the GainmersTOKEN itself. The token has 18 decimals and will be an utility token with a fixed supply of 100, 000, 000 gain tokens.
The token is fully compatible with ERC20 standard. It uses `SafeMath.sol` by Open Zeppelin.

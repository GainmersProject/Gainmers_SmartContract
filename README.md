# Gainmers Token Crowdsale
In this document we will cover the token sale specifications and details for the Initial Coin Offering of the Gainmers Project.

## ICO Specifications

* Total Token Supply: 100,000,000 GMR
* Crowdsale Supply: 60,000,000 GMR
* Pricing: 1 ETH = 1660 GMR 
* HardCap: 30000 ETH
* Bonus: 20% the first week after contract deployment, 10% the second and 5 % the third week.
* Start Date: April 9 , 00 am  UTC-5 
* End Date:  May 6 , 12 pm UTC-5

## Detailed description

### Overview of the CrowdSale Flow
 Overview of the dates on the ICO
1. April 9, 00 am  UTC-5 is the start date for the ICO. We will deploy the `GainmersSALE.sol` contract that day, in which the `GainmersTOKEN.sol` contract will be called, creating the GMR token.
2. During the first week there will be a Bonus for the contributors of the project of 20% (April 9 until April 15).
3. During the second week there will be a Bonus for the contributors of the project of 10% (April 16 until April 22).
4. During the third week there will be a Bonus for the contributors of the project of 5% (April 23 until April 29).
5. May 6, 12 pm  UTC-5 is the end date for the ICO project.

#### The crowdsale (GainmersSALE.sol)

`GainmersSALE.sol` contains the implementation of the capped crowdsale. We used Open Zeppelin (OZ) OpenSource contracts for deveploping the smartcontract.
The `GainmersSALE.sol` contract inherits from `CappedCrowdsale.sol` by OZ providing the hardcap for the project. Also `CappedCrowdsale.sol` inherits form `ModifiedCrowdsale.sol`. To obtain this file we did small changes in the `Crowdsale.sol` file given by the OZ dev group, and so we created `ModifiedCrowdsale.sol`, in which we added some basic checks for the token deployment. This file will be the one handling the tokens and using the function `getBonus()` to calculate the exact ammount of tokens that will be distributed to each contributor address.

#### The token (GainmersTOKEN.sol)

`GainmersTOKEN.sol` contains the GainmersTOKEN itself. The token has 18 decimals and will be an utility token with a fixed supply of 100, 000, 000 gain tokens.
The token is fully compatible with ERC20 standard. It uses `SafeMath.sol` by Open Zeppelin.
